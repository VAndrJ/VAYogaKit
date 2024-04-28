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
    @MainActor var sublayouts: [any VAYogaLayout] { get set }

    @MainActor
    func sizeThatFits(_ size: CGSize) -> CGSize
    @MainActor
    func setNeedsLayout()
}

public extension VAYogaLayout {

    @MainActor
    func setNeedsRelayout() {
        if layoutType == .root || layoutType == .container {
            setNeedsLayout()
        } else {
            let parent: AnyObject? = node?.parent?.getContext()
            (parent as? VAYogaLayout)?.setNeedsRelayout()
        }
    }
}

public enum VAYogaLayoutType {
    case layout
    case view
    case root
    case container
    case selfSizedView
}

extension VAYogaLayout {
    @MainActor public var isLeaf: Bool { sublayouts.isEmpty }

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
            let width = node.widthValue
            let height = node.heightValue
            let origin: CGPoint = keepingOrigin ? frame.origin : .zero
            frame = .init(
                origin: .init(x: topLeft.x + origin.x, y: topLeft.y + origin.y),
                size: .init(width: width, height: height)
            )
        case .root, .layout:
            break
        }
        if !isLeaf {
            sublayouts.forEach { $0.applyLayoutToHierarchy(keepingOrigin: false) }
        }
    }
}
