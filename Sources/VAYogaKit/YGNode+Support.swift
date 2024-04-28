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
    var maxWidth: YGValue {
        get { YGNodeStyleGetMaxWidth(self) }
        set {
            switch newValue.unit {
            case .undefined:
                YGNodeStyleSetMaxWidth(self, .nan)
            case .point:
                YGNodeStyleSetMaxWidth(self, newValue.value)
            case .percent:
                YGNodeStyleSetMaxWidthPercent(self, newValue.value)
            default:
                assertionFailure("Not implemented")
            }
        }
    }
    var maxHeight: YGValue {
        get { YGNodeStyleGetMaxHeight(self) }
        set {
            switch newValue.unit {
            case .undefined:
                YGNodeStyleSetMaxHeight(self, .nan)
            case .point:
                YGNodeStyleSetMaxHeight(self, newValue.value)
            case .percent:
                YGNodeStyleSetMaxHeightPercent(self, newValue.value)
            default:
                assertionFailure("Not implemented")
            }
        }
    }
    var padding: YGValue {
        get { getPadding(edge: .all) }
        set { setPadding(newValue: newValue, edge: .all) }
    }
    var paddingVertical: YGValue {
        get { getPadding(edge: .vertical) }
        set { setPadding(newValue: newValue, edge: .vertical) }
    }
    var paddingHorizontal: YGValue {
        get { getPadding(edge: .horizontal) }
        set { setPadding(newValue: newValue, edge: .horizontal) }
    }
    var paddingEnd: YGValue {
        get { getPadding(edge: .end) }
        set { setPadding(newValue: newValue, edge: .end) }
    }
    var paddingStart: YGValue {
        get { getPadding(edge: .start) }
        set { setPadding(newValue: newValue, edge: .start) }
    }
    var paddingBottom: YGValue {
        get { getPadding(edge: .bottom) }
        set { setPadding(newValue: newValue, edge: .bottom) }
    }
    var paddingRight: YGValue {
        get { getPadding(edge: .right) }
        set { setPadding(newValue: newValue, edge: .right) }
    }
    var paddingTop: YGValue {
        get { getPadding(edge: .top) }
        set { setPadding(newValue: newValue, edge: .top) }
    }
    var paddingLeft: YGValue {
        get { getPadding(edge: .left) }
        set { setPadding(newValue: newValue, edge: .left) }
    }

    @inline(__always) private func getPadding(edge: YGEdge) -> YGValue {
        YGNodeStyleGetPadding(self, edge)
    }

    @inline(__always) private func setPadding(newValue: YGValue, edge: YGEdge) {
        switch newValue.unit {
        case .undefined:
            YGNodeStyleSetPadding(self, edge, .nan)
        case .point:
            YGNodeStyleSetPadding(self, edge, newValue.value)
        case .percent:
            YGNodeStyleSetPaddingPercent(self, edge, newValue.value)
        default:
            assertionFailure("Not implemented")
        }
    }

    var marginLeft: YGValue {
        get { getMargin(edge: .left) }
        set { setMargin(newValue: newValue, edge: .left) }
    }
    var marginTop: YGValue {
        get { getMargin(edge: .top) }
        set { setMargin(newValue: newValue, edge: .top) }
    }
    var marginRight: YGValue {
        get { getMargin(edge: .right) }
        set { setMargin(newValue: newValue, edge: .right) }
    }
    var marginBottom: YGValue {
        get { getMargin(edge: .bottom) }
        set { setMargin(newValue: newValue, edge: .bottom) }
    }
    var marginStart: YGValue {
        get { getMargin(edge: .start) }
        set { setMargin(newValue: newValue, edge: .start) }
    }
    var marginEnd: YGValue {
        get { getMargin(edge: .end) }
        set { setMargin(newValue: newValue, edge: .end) }
    }
    var marginHorizontal: YGValue {
        get { getMargin(edge: .horizontal) }
        set { setMargin(newValue: newValue, edge: .horizontal) }
    }
    var marginVertical: YGValue {
        get { getMargin(edge: .vertical) }
        set { setMargin(newValue: newValue, edge: .vertical) }
    }
    var margin: YGValue {
        get { getMargin(edge: .all) }
        set { setMargin(newValue: newValue, edge: .all) }
    }

    @inline(__always) private func getMargin(edge: YGEdge) -> YGValue {
        YGNodeStyleGetMargin(self, edge)
    }

    @inline(__always) private func setMargin(newValue: YGValue, edge: YGEdge) {
        switch newValue.unit {
        case .undefined:
            YGNodeStyleSetMargin(self, edge, .nan)
        case .point:
            YGNodeStyleSetMargin(self, edge, newValue.value)
        case .percent:
            YGNodeStyleSetMarginPercent(self, edge, newValue.value)
        case .auto:
            YGNodeStyleSetMarginAuto(self, edge)
        default:
            assertionFailure("Not implemented")
        }
    }

    var direction: YGDirection {
        get { YGNodeStyleGetDirection(self) }
        set { YGNodeStyleSetDirection(self, newValue) }
    }
    var flexShrink: Float {
        get { YGNodeStyleGetFlexShrink(self) }
        set { YGNodeStyleSetFlexShrink(self, newValue) }
    }
    var justifyContent: YGJustify {
        get { YGNodeStyleGetJustifyContent(self) }
        set { YGNodeStyleSetJustifyContent(self, newValue) }
    }
    var alignContent: YGAlign {
        get { YGNodeStyleGetAlignContent(self) }
        set { YGNodeStyleSetAlignContent(self, newValue) }
    }
    var alignItems: YGAlign {
        get { YGNodeStyleGetAlignItems(self) }
        set { YGNodeStyleSetAlignItems(self, newValue) }
    }
    var alignSelf: YGAlign {
        get { YGNodeStyleGetAlignSelf(self) }
        set { YGNodeStyleSetAlignSelf(self, newValue) }
    }
    var flexWrap: YGWrap {
        get { YGNodeStyleGetFlexWrap(self) }
        set { YGNodeStyleSetFlexWrap(self, newValue) }
    }
    var overflow: YGOverflow {
        get { YGNodeStyleGetOverflow(self) }
        set { YGNodeStyleSetOverflow(self, newValue) }
    }
    var display: YGDisplay {
        get { YGNodeStyleGetDisplay(self) }
        set { YGNodeStyleSetDisplay(self, newValue) }
    }
    var flex: Float {
        get { YGNodeStyleGetFlex(self) }
        set { YGNodeStyleSetFlex(self, newValue) }
    }
    var flexGrow: Float {
        get { YGNodeStyleGetFlexGrow(self) }
        set { YGNodeStyleSetFlexGrow(self, newValue) }
    }
    var aspectRatio: Float {
        get { YGNodeStyleGetAspectRatio(self) }
        set { YGNodeStyleSetAspectRatio(self, newValue) }
    }
    var flexBasis: YGValue {
        get { YGNodeStyleGetFlexBasis(self) }
        set {
            switch newValue.unit {
            case .point:
                YGNodeStyleSetFlexBasis(self, newValue.value)
            case .percent:
                YGNodeStyleSetFlexBasisPercent(self, newValue.value)
            case .auto:
                YGNodeStyleSetFlexBasisAuto(self)
            default:
                assertionFailure("Not implemented")
            }
        }
    }
    var left: YGValue {
        get { getPosition(edge: YGEdgeLeft) }
        set { setPosition(newValue: newValue, edge: YGEdgeLeft) }
    }
    var top: YGValue {
        get { getPosition(edge: YGEdgeTop) }
        set { setPosition(newValue: newValue, edge: YGEdgeTop) }
    }
    var right: YGValue {
        get { getPosition(edge: YGEdgeRight) }
        set { setPosition(newValue: newValue, edge: YGEdgeRight) }
    }
    var bottom: YGValue {
        get { getPosition(edge: YGEdgeBottom) }
        set { setPosition(newValue: newValue, edge: YGEdgeBottom) }
    }
    var start: YGValue {
        get { getPosition(edge: YGEdgeStart) }
        set { setPosition(newValue: newValue, edge: YGEdgeStart) }
    }
    var end: YGValue {
        get { getPosition(edge: YGEdgeEnd) }
        set { setPosition(newValue: newValue, edge: YGEdgeEnd) }
    }

    @inline(__always) private func getPosition(edge: YGEdge) -> YGValue {
        YGNodeStyleGetPosition(self, edge)
    }

    @inline(__always) private func setPosition(newValue: YGValue, edge: YGEdge) {
        switch newValue.unit {
        case .undefined:
            YGNodeStyleSetPosition(self, edge, .nan)
        case .point:
            YGNodeStyleSetPosition(self, edge, newValue.value)
        case .percent:
            YGNodeStyleSetPositionPercent(self, edge, newValue.value)
        default:
            assertionFailure("Not implemented")
        }
    }

    var borderLeftWidth: Float {
        get { getBorder(edge: YGEdgeLeft) }
        set { setBorder(newValue: newValue, edge: YGEdgeLeft) }
    }
    var borderTopWidth: Float {
        get { getBorder(edge: YGEdgeTop) }
        set { setBorder(newValue: newValue, edge: YGEdgeTop) }
    }

    @inline(__always) private func getBorder(edge: YGEdge) -> Float {
        YGNodeStyleGetBorder(self, edge)
    }

    @inline(__always) private func setBorder(newValue: Float, edge: YGEdge) {
        YGNodeStyleSetBorder(self, edge, newValue)
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
