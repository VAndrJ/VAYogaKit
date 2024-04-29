//
//  VAYogaLayout.swift
//
//
//  Created by VAndrJ on 26.04.2024.
//

import UIKit
import yoga

public protocol VAYogaLayout: AnyObject {
    @MainActor var layoutType: VAYogaLayoutType { get }
    @MainActor var node: YGNodeRef! { get set }
    @MainActor var frame: CGRect { get set }
    @MainActor var sublayouts: [any VAYogaLayout] { get set }
    @MainActor var layout: any VAYogaLayout { get }

    @MainActor
    func sizeThatFits(_ size: CGSize) -> CGSize
    @MainActor
    func setNeedsLayout()
}

public enum VAYogaLayoutType {
    case layout
    case view
    case root
    case container
    case selfSizedView
}

public enum VAYogaLayoutMode {
    case fitContainer
    case adjustHeight
    case adjustWidth
}

public extension VAYogaLayout {
    @MainActor var isLeaf: Bool { sublayouts.isEmpty }

    @MainActor
    func setNeedsRelayout() {
        if layoutType == .root || layoutType == .container {
            setNeedsLayout()
        } else {
            let parent: AnyObject? = node?.parent?.getContext()
            (parent as? VAYogaLayout)?.setNeedsRelayout()
        }
    }

    @MainActor
    func calculateLayout(for size: CGSize) {
        assertMain()
        buildNodesHierarchy()
        YGNodeCalculateLayout(
            node,
            Float(size.width),
            Float(size.height),
            YGNodeStyleGetDirection(node)
        )
    }

    @MainActor
    func calculateLayout(width: Float, height: Float) {
        assertMain()
        buildNodesHierarchy()
        YGNodeCalculateLayout(
            node,
            width,
            height,
            YGNodeStyleGetDirection(node)
        )
    }

    @MainActor
    func buildNodesHierarchy() {
        if isLeaf {
            node.removeAllChildren()
            if !node.hasMeasureFunc {
                node.setMeasureFunc(measureViewFunc)
            }
        } else {
            node.removeMeasureFunc()
            let subviewsToInclude = sublayouts
            if !node.hasSameChildren(sublayouts: subviewsToInclude) {
                node.removeAllChildren()
                for i in subviewsToInclude.indices {
                    let child: YGNodeRef! = subviewsToInclude[i].node
                    child.removeFromParent()
                    node.insert(child: child, at: i)
                }
            }
            subviewsToInclude.forEach {
                $0.buildNodesHierarchy()
            }
        }
    }

    @MainActor
    func layout(mode: VAYogaLayoutMode = .fitContainer) {
        switch mode {
        case .fitContainer:
            applyLayout(keepingOrigin: true)
        case .adjustHeight:
            applyLayout(keepingOrigin: true, flexibility: .flexibleHeight)
        case .adjustWidth:
            applyLayout(keepingOrigin: true, flexibility: .flexibleWidth)
        }
    }

    @MainActor
    func applyLayout(keepingOrigin: Bool) {
        calculateLayout(for: frame.size)
        applyLayoutToHierarchy(keepingOrigin: keepingOrigin)
    }

    @MainActor
    func applyLayout(keepingOrigin: Bool, flexibility: VAYogaFlexibility) {
        var size = frame.size
        if flexibility.contains(.flexibleWidth) {
            size.width = .nan
        }
        if flexibility.contains(.flexibleHeight) {
            size.height = .nan
        }
        calculateLayout(for: size)
        applyLayoutToHierarchy(keepingOrigin: keepingOrigin)
    }

    @MainActor
    func applyLayoutToHierarchy(keepingOrigin: Bool) {
        assertMain()
        switch layoutType {
        case .view, .selfSizedView, .container:
            let topLeft = node.absolutePosition
            if keepingOrigin {
                frame = .init(
                    origin: .init(x: topLeft.x + frame.origin.x, y: topLeft.y + frame.origin.y),
                    size: .init(width: node.widthValue, height: node.heightValue)
                )
            } else {
                frame = .init(
                    origin: topLeft,
                    size: .init(width: node.widthValue, height: node.heightValue)
                )
            }
        case .root, .layout:
            break
        }
        if !isLeaf {
            sublayouts.forEach { $0.applyLayoutToHierarchy(keepingOrigin: false) }
        }
    }

    @MainActor
    func applyLayoutToTableCellHierarchy(width: CGFloat, calculated: (CGFloat) -> Void) {
        assertMain()
        calculateLayout(width: Float(width), height: .nan)
        switch layoutType {
        case .view, .selfSizedView:
            frame = .init(
                origin: node.absolutePosition,
                size: .init(width: node.widthValue, height: node.heightValue)
            )
        case .container:
            calculated(node.heightValue)
        case .root, .layout:
            break
        }
        if !isLeaf {
            sublayouts.forEach { $0.applyLayoutToHierarchy(keepingOrigin: false) }
        }
    }
}
