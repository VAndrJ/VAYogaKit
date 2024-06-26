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
        node.addBaselineFuncIfNeeded(object: object)

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
    var width: YGValue {
        get { YGNodeStyleGetWidth(self) }
        set {
            switch newValue.unit {
            case .undefined:
                YGNodeStyleSetWidth(self, .nan)
            case .point:
                YGNodeStyleSetWidth(self, newValue.value)
            case .percent:
                YGNodeStyleSetWidthPercent(self, newValue.value)
            case .auto:
                YGNodeStyleSetWidthAuto(self)
            default:
                assertionFailure("Not implemented")
            }
        }
    }
    var height: YGValue {
        get { YGNodeStyleGetHeight(self) }
        set {
            switch newValue.unit {
            case .undefined:
                YGNodeStyleSetHeight(self, .nan)
            case .point:
                YGNodeStyleSetHeight(self, newValue.value)
            case .percent:
                YGNodeStyleSetHeightPercent(self, newValue.value)
            case .auto:
                YGNodeStyleSetHeightAuto(self)
            default:
                assertionFailure("Not implemented")
            }
        }
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
            case .undefined:
                YGNodeStyleSetFlexBasis(self, .nan)
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
    var borderRightWidth: Float {
        get { getBorder(edge: YGEdgeRight) }
        set { setBorder(newValue: newValue, edge: YGEdgeRight) }
    }
    var borderBottomWidth: Float {
        get { getBorder(edge: YGEdgeBottom) }
        set { setBorder(newValue: newValue, edge: YGEdgeBottom) }
    }
    var borderStartWidth: Float {
        get { getBorder(edge: YGEdgeStart) }
        set { setBorder(newValue: newValue, edge: YGEdgeStart) }
    }
    var borderEndWidth: Float {
        get { getBorder(edge: YGEdgeEnd) }
        set { setBorder(newValue: newValue, edge: YGEdgeEnd) }
    }
    var borderWidth: Float {
        get { getBorder(edge: YGEdgeAll) }
        set { setBorder(newValue: newValue, edge: YGEdgeAll) }
    }

    @inline(__always) private func getBorder(edge: YGEdge) -> Float {
        YGNodeStyleGetBorder(self, edge)
    }

    @inline(__always) private func setBorder(newValue: Float, edge: YGEdge) {
        YGNodeStyleSetBorder(self, edge, newValue)
    }

    var columnGap: Float {
        get { getGap(gutter: YGGutterColumn) }
        set { setGap(newValue: newValue, gutter: YGGutterColumn) }
    }
    var rowGap: Float {
        get { getGap(gutter: YGGutterRow) }
        set { setGap(newValue: newValue, gutter: YGGutterRow) }
    }
    var gap: Float {
        get { getGap(gutter: YGGutterAll) }
        set { setGap(newValue: newValue, gutter: YGGutterAll) }
    }

    @inline(__always) private func getGap(gutter: YGGutter) -> Float {
        YGNodeStyleGetGap(self, gutter)
    }

    @inline(__always) private func setGap(newValue: Float, gutter: YGGutter) {
        YGNodeStyleSetGap(self, gutter, newValue)
    }

    var positionType: YGPositionType {
        get { YGNodeStyleGetPositionType(self) }
        set { YGNodeStyleSetPositionType(self, newValue) }
    }

    @MainActor
    var absolutePosition: CGPoint {
        var absolutePosition = CGPoint(x: leftValue, y: topValue)
        var currentNode: YGNodeRef? = parent
        while let node = currentNode {
            let layoutType = (Unmanaged<AnyObject>.fromOpaque(YGNodeGetContext(node)).takeUnretainedValue() as? VAYogaLayout)?.layoutType
            if layoutType == .layout {
                absolutePosition.x += node.leftValue
                absolutePosition.y += node.topValue
            } else if layoutType == .view || layoutType == .containerView || layoutType == .contentView {
                return absolutePosition
            }

            currentNode = YGNodeGetParent(node)
        }

        return absolutePosition
    }

    @inline(__always) func setBaselineFunc(_ baselineFunc: YGBaselineFunc) {
        YGNodeSetBaselineFunc(self, baselineFunc)
    }

    @MainActor
    func addBaselineFuncIfNeeded(object: AnyObject) {
        guard !hasBaselineFunc else { return }

        if object is UILabel {
            setBaselineFunc(baselineLabelFunc)
        } else if object is UITextView {
            setBaselineFunc(baselineTextViewFunc)
        } else if object is UITextField {
            setBaselineFunc(baselineTextFieldFunc)
        }
    }

    @MainActor
    @inline(__always) func getContext<T: AnyObject>() -> T {
        Unmanaged<T>.fromOpaque(YGNodeGetContext(self)).takeUnretainedValue()
    }

    @inline(__always) func markDirty() {
        YGNodeMarkDirty(self)
    }

    @MainActor
    func markDirtyIfAvailable() {
        if hasMeasureFunc {
            markDirty()
            (Unmanaged<AnyObject>.fromOpaque(YGNodeGetContext(self)).takeUnretainedValue() as? VAYogaLayout)?.setNeedsRelayout()
        }
    }

    @inline(__always) func setMeasureFunc(_ measureFunc: YGMeasureFunc) {
        YGNodeSetMeasureFunc(self, measureFunc)
    }

    @inline(__always) func removeMeasureFunc() {
        YGNodeSetMeasureFunc(self, nil)
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
@MainActor public var measureViewFunc: @convention(c) (
    _ node: YGNodeRef?,
    _ width: Float,
    _ widthMode: YGMeasureMode,
    _ height: Float,
    _ heightMode: YGMeasureMode
) -> YGSize = { node, width, widthMode, height, heightMode in
    guard let layout = Unmanaged<AnyObject>.fromOpaque(YGNodeGetContext(node)).takeUnretainedValue() as? any VAYogaLayout else {
        return .init(width: .zero, height: .zero)
    }
    
    let constrainedWidth = widthMode == .undefined ? .greatestFiniteMagnitude : width
    let constrainedHeight = heightMode == .undefined ? .greatestFiniteMagnitude : height
    var sizeThatFits: CGSize = .zero
    if layout.layoutType == .selfSizedView {
        sizeThatFits = layout.sizeThatFits(.init(
            width: constrainedWidth.cg,
            height: constrainedHeight.cg
        ))
    }
    
    return .init(
        width: constrainedWidth.sanitize(
            measured: sizeThatFits.width,
            mode: widthMode
        ),
        height: constrainedHeight.sanitize(
            measured: sizeThatFits.height,
            mode: heightMode
        )
    )
}
