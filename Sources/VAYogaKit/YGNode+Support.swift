//
//  YGNode+Support.swift
//
//
//  Created by Volodymyr Andriienko on 25.04.2024.
//

import UIKit
import yoga

public extension YGNodeRef {

    @MainActor
    static func new(for object: AnyObject) -> YGNodeRef {
        let node: YGNodeRef! = YGNodeNewWithConfig(VAYogaConfig.globalConfig)
        YGNodeSetContext(node, Unmanaged.passUnretained(object).toOpaque())
        node.addMeasureBaselineFuncIfNeeded(object: object)

        return node
    }

    var childCount: Int { YGNodeGetChildCount(self) }
    var parent: YGNodeRef? { YGNodeGetParent(self) }
    var hasBaselineFunc: Bool { YGNodeHasBaselineFunc(self) }
    var hasMeasureFunc: Bool { YGNodeHasMeasureFunc(self) }
    var leftValue: CGFloat {
        let value = YGNodeLayoutGetLeft(self)
        if value.isNaN {
            return .zero
        } else {
            return value.cg
        }
    }
    var topValue: CGFloat {
        let value = YGNodeLayoutGetTop(self)
        if value.isNaN {
            return .zero
        } else {
            return value.cg
        }
    }
    var widthValue: CGFloat {
        let value = YGNodeLayoutGetWidth(self)
        if value.isNaN || value.isLess(than: .zero) {
            return .zero
        } else {
            return value.cg
        }
    }
    var heightValue: CGFloat {
        let value = YGNodeLayoutGetHeight(self)
        if value.isNaN || value.isLess(than: .zero) {
            return .zero
        } else {
            return value.cg
        }
    }
    var flexDirection: YGFlexDirection {
        get { YGNodeStyleGetFlexDirection(self) }
        set { YGNodeStyleSetFlexDirection(self, newValue) }
    }
    var minWidth: YGValue {
        get { YGNodeStyleGetMinWidth(self) }
        set {
            switch newValue.unit {
            case .undefined:
                YGNodeStyleSetMinWidth(self, .nan)
            case .point:
                YGNodeStyleSetMinWidth(self, newValue.value)
            case .percent:
                YGNodeStyleSetMinWidthPercent(self, newValue.value)
            default:
                assertionFailure("Not implemented")
            }
        }
    }
    var minHeight: YGValue {
        get { YGNodeStyleGetMinHeight(self) }
        set {
            switch newValue.unit {
            case .undefined:
                YGNodeStyleSetMinHeight(self, .nan)
            case .point:
                YGNodeStyleSetMinHeight(self, newValue.value)
            case .percent:
                YGNodeStyleSetMinHeightPercent(self, newValue.value)
            default:
                assertionFailure("Not implemented")
            }
        }
    }

    @MainActor
    func addMeasureBaselineFuncIfNeeded(object: AnyObject) {
        guard !hasBaselineFunc else { return }

        if object is UILabel {
            YGNodeSetBaselineFunc(self, baselineLabelFunc)
        } else if object is UITextView {
            YGNodeSetBaselineFunc(self, baselineTextViewFunc)
        } else if object is UITextField {
            YGNodeSetBaselineFunc(self, baselineTextFieldFunc)
        }
    }

    @inline(__always) func markDirty() {
        YGNodeMarkDirty(self)
    }

    @inline(__always) func setMeasureFunc(_ measureFunc: YGMeasureFunc) {
        YGNodeSetMeasureFunc(self, measureFunc)
    }

    @inline(__always) func removeFromParent() {
        parent?.remove(child: self)
    }

    @inline(__always) func remove(child: YGNodeRef?) {
        YGNodeRemoveChild(self, child)
    }

    @inline(__always) func removeAllChildren() {
        YGNodeRemoveAllChildren(self)
    }

    @inline(__always) func getGhild(at index: Int) -> YGNodeRef? {
        YGNodeGetChild(self, index)
    }

    @inline(__always) func insert(child: YGNodeRef, at index: Int) {
        YGNodeInsertChild(self, child, index)
    }
}

public extension YGNodeRef? {

    @MainActor
    func hasSameChildren(sublayouts: [any VAYogaLayout]) -> Bool {
        // TODO: - Optimization for recreated instances like column?
        guard let self, self.childCount == sublayouts.count else {
            return false
        }

        for i in sublayouts.indices {
            if self.getGhild(at: i) != sublayouts[i].node {
                return false
            }
        }

        return true
    }
}

@MainActor public var baselineLabelFunc: @convention(c) (
    _ node: YGNodeRef?,
    _ width: Float,
    _ height: Float
) -> Float = { node, _, _ in
    guard let view: UILabel = node?.getContext() else {
        return 0
    }

    return Float(view.font.ascender)
}
@MainActor public var baselineTextViewFunc: @convention(c) (
    _ node: YGNodeRef?,
    _ width: Float,
    _ height: Float
) -> Float = { node, _, _ in
    guard let view: UITextView = node?.getContext() else {
        return 0
    }

    return Float((view.font?.ascender ?? 0) + view.contentInset.top + view.textContainerInset.top)
}
@MainActor public var baselineTextFieldFunc: @convention(c) (
    _ node: YGNodeRef?,
    _ width: Float,
    _ height: Float
) -> Float = { node, _, _ in
    guard let view: UITextField = node?.getContext() else {
        return 0
    }

    let ascender = Float(view.font?.ascender ?? 0)
    switch view.borderStyle {
    case .none: return ascender
    case .line: return ascender + 4
    case .bezel, .roundedRect: return ascender + 7
    @unknown default: return ascender
    }
}
