//
//  YGNode+Support.swift
//
//
//  Created by Volodymyr Andriienko on 25.04.2024.
//

import UIKit
import yoga

extension YGNodeRef {
    public static func new(for object: AnyObject) -> YGNodeRef {
        let node: YGNodeRef! = YGNodeNewWithConfig(VAYogaConfig.globalConfig)
        node.setContext(object)
        node.addBaselineFuncIfNeeded(object: object)

        return node
    }

    public var childCount: Int { YGNodeGetChildCount(self) }
    public var parent: YGNodeRef? { YGNodeGetParent(self) }
    public var hasBaselineFunc: Bool { YGNodeHasBaselineFunc(self) }
    public var hasMeasureFunc: Bool { YGNodeHasMeasureFunc(self) }
    public var leftValue: CGFloat {
        let value = YGNodeLayoutGetLeft(self)
        if value.isNaN {
            return .zero
        } else {
            return value.cg
        }
    }
    public var topValue: CGFloat {
        let value = YGNodeLayoutGetTop(self)
        if value.isNaN {
            return .zero
        } else {
            return value.cg
        }
    }
    public var widthValue: CGFloat {
        let value = YGNodeLayoutGetWidth(self)
        if value.isNaN || value.isLess(than: .zero) {
            return .zero
        } else {
            return value.cg
        }
    }
    public var heightValue: CGFloat {
        let value = YGNodeLayoutGetHeight(self)
        if value.isNaN || value.isLess(than: .zero) {
            return .zero
        } else {
            return value.cg
        }
    }
    public var flexDirection: YGFlexDirection {
        get { YGNodeStyleGetFlexDirection(self) }
        set { YGNodeStyleSetFlexDirection(self, newValue) }
    }
    public var width: YGValue {
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
    public var height: YGValue {
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
    public var minWidth: YGValue {
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
    public var minHeight: YGValue {
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
    public var maxWidth: YGValue {
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
    public var maxHeight: YGValue {
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
    public var padding: YGValue {
        get { getPadding(edge: .all) }
        set { setPadding(newValue: newValue, edge: .all) }
    }
    public var paddingVertical: YGValue {
        get { getPadding(edge: .vertical) }
        set { setPadding(newValue: newValue, edge: .vertical) }
    }
    public var paddingHorizontal: YGValue {
        get { getPadding(edge: .horizontal) }
        set { setPadding(newValue: newValue, edge: .horizontal) }
    }
    public var paddingEnd: YGValue {
        get { getPadding(edge: .end) }
        set { setPadding(newValue: newValue, edge: .end) }
    }
    public var paddingStart: YGValue {
        get { getPadding(edge: .start) }
        set { setPadding(newValue: newValue, edge: .start) }
    }
    public var paddingBottom: YGValue {
        get { getPadding(edge: .bottom) }
        set { setPadding(newValue: newValue, edge: .bottom) }
    }
    public var paddingRight: YGValue {
        get { getPadding(edge: .right) }
        set { setPadding(newValue: newValue, edge: .right) }
    }
    public var paddingTop: YGValue {
        get { getPadding(edge: .top) }
        set { setPadding(newValue: newValue, edge: .top) }
    }
    public var paddingLeft: YGValue {
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

    public var marginLeft: YGValue {
        get { getMargin(edge: .left) }
        set { setMargin(newValue: newValue, edge: .left) }
    }
    public var marginTop: YGValue {
        get { getMargin(edge: .top) }
        set { setMargin(newValue: newValue, edge: .top) }
    }
    public var marginRight: YGValue {
        get { getMargin(edge: .right) }
        set { setMargin(newValue: newValue, edge: .right) }
    }
    public var marginBottom: YGValue {
        get { getMargin(edge: .bottom) }
        set { setMargin(newValue: newValue, edge: .bottom) }
    }
    public var marginStart: YGValue {
        get { getMargin(edge: .start) }
        set { setMargin(newValue: newValue, edge: .start) }
    }
    public var marginEnd: YGValue {
        get { getMargin(edge: .end) }
        set { setMargin(newValue: newValue, edge: .end) }
    }
    public var marginHorizontal: YGValue {
        get { getMargin(edge: .horizontal) }
        set { setMargin(newValue: newValue, edge: .horizontal) }
    }
    public var marginVertical: YGValue {
        get { getMargin(edge: .vertical) }
        set { setMargin(newValue: newValue, edge: .vertical) }
    }
    public var margin: YGValue {
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

    public var direction: YGDirection {
        get { YGNodeStyleGetDirection(self) }
        set { YGNodeStyleSetDirection(self, newValue) }
    }
    public var flexShrink: Float {
        get { YGNodeStyleGetFlexShrink(self) }
        set { YGNodeStyleSetFlexShrink(self, newValue) }
    }
    public var justifyContent: YGJustify {
        get { YGNodeStyleGetJustifyContent(self) }
        set { YGNodeStyleSetJustifyContent(self, newValue) }
    }
    public var alignContent: YGAlign {
        get { YGNodeStyleGetAlignContent(self) }
        set { YGNodeStyleSetAlignContent(self, newValue) }
    }
    public var alignItems: YGAlign {
        get { YGNodeStyleGetAlignItems(self) }
        set { YGNodeStyleSetAlignItems(self, newValue) }
    }
    public var alignSelf: YGAlign {
        get { YGNodeStyleGetAlignSelf(self) }
        set { YGNodeStyleSetAlignSelf(self, newValue) }
    }
    public var flexWrap: YGWrap {
        get { YGNodeStyleGetFlexWrap(self) }
        set { YGNodeStyleSetFlexWrap(self, newValue) }
    }
    public var overflow: YGOverflow {
        get { YGNodeStyleGetOverflow(self) }
        set { YGNodeStyleSetOverflow(self, newValue) }
    }
    public var display: YGDisplay {
        get { YGNodeStyleGetDisplay(self) }
        set { YGNodeStyleSetDisplay(self, newValue) }
    }
    public var flex: Float {
        get { YGNodeStyleGetFlex(self) }
        set { YGNodeStyleSetFlex(self, newValue) }
    }
    public var flexGrow: Float {
        get { YGNodeStyleGetFlexGrow(self) }
        set { YGNodeStyleSetFlexGrow(self, newValue) }
    }
    public var aspectRatio: Float {
        get { YGNodeStyleGetAspectRatio(self) }
        set { YGNodeStyleSetAspectRatio(self, newValue) }
    }
    public var flexBasis: YGValue {
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
    public var left: YGValue {
        get { getPosition(edge: .left) }
        set { setPosition(newValue: newValue, edge: .left) }
    }
    public var top: YGValue {
        get { getPosition(edge: .top) }
        set { setPosition(newValue: newValue, edge: .top) }
    }
    public var right: YGValue {
        get { getPosition(edge: .right) }
        set { setPosition(newValue: newValue, edge: .right) }
    }
    public var bottom: YGValue {
        get { getPosition(edge: .bottom) }
        set { setPosition(newValue: newValue, edge: .bottom) }
    }
    public var start: YGValue {
        get { getPosition(edge: .start) }
        set { setPosition(newValue: newValue, edge: .start) }
    }
    public var end: YGValue {
        get { getPosition(edge: .end) }
        set { setPosition(newValue: newValue, edge: .end) }
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

    public var borderLeftWidth: Float {
        get { getBorder(edge: .left) }
        set { setBorder(newValue: newValue, edge: .left) }
    }
    public var borderTopWidth: Float {
        get { getBorder(edge: .top) }
        set { setBorder(newValue: newValue, edge: .top) }
    }
    public var borderRightWidth: Float {
        get { getBorder(edge: .right) }
        set { setBorder(newValue: newValue, edge: .right) }
    }
    public var borderBottomWidth: Float {
        get { getBorder(edge: .bottom) }
        set { setBorder(newValue: newValue, edge: .bottom) }
    }
    public var borderStartWidth: Float {
        get { getBorder(edge: .start) }
        set { setBorder(newValue: newValue, edge: .start) }
    }
    public var borderEndWidth: Float {
        get { getBorder(edge: .end) }
        set { setBorder(newValue: newValue, edge: .end) }
    }
    public var borderWidth: Float {
        get { getBorder(edge: .all) }
        set { setBorder(newValue: newValue, edge: .all) }
    }

    @inline(__always) private func getBorder(edge: YGEdge) -> Float {
        YGNodeStyleGetBorder(self, edge)
    }

    @inline(__always) private func setBorder(newValue: Float, edge: YGEdge) {
        YGNodeStyleSetBorder(self, edge, newValue)
    }

    public var columnGap: Float {
        get { getGap(gutter: .column) }
        set { setGap(newValue: newValue, gutter: .column) }
    }
    public var rowGap: Float {
        get { getGap(gutter: .row) }
        set { setGap(newValue: newValue, gutter: .row) }
    }
    public var gap: Float {
        get { getGap(gutter: .all) }
        set { setGap(newValue: newValue, gutter: .all) }
    }

    @inline(__always) private func getGap(gutter: YGGutter) -> Float {
        YGNodeStyleGetGap(self, gutter)
    }

    @inline(__always) private func setGap(newValue: Float, gutter: YGGutter) {
        YGNodeStyleSetGap(self, gutter, newValue)
    }

    public var positionType: YGPositionType {
        get { YGNodeStyleGetPositionType(self) }
        set { YGNodeStyleSetPositionType(self, newValue) }
    }

    public var absolutePosition: CGPoint {
        var absolutePosition = CGPoint(x: leftValue, y: topValue)
        var currentNode: YGNodeRef? = parent
        while let node = currentNode {
            let layoutType = (node.getContext() as? any VAYogaLayout)?.layoutType
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

    @inline(__always) public func setBaselineFunc(_ baselineFunc: YGBaselineFunc) {
        YGNodeSetBaselineFunc(self, baselineFunc)
    }

    public func addBaselineFuncIfNeeded(object: AnyObject) {
        guard !hasBaselineFunc else { return }

        if object is UILabel {
            setBaselineFunc(baselineLabelFunc)
        } else if object is UITextView {
            setBaselineFunc(baselineTextViewFunc)
        } else if object is UITextField {
            setBaselineFunc(baselineTextFieldFunc)
        }
    }

    @inline(__always) public func setContext(_ object: AnyObject) {
        YGNodeSetContext(self, Unmanaged.passUnretained(object).toOpaque())
    }

    @inline(__always) public func clearContext() {
        YGNodeSetContext(self, nil)
    }

    @inline(__always) public func getContext() -> AnyObject? {
        guard let context = YGNodeGetContext(self) else {
            return nil
        }

        return Unmanaged<AnyObject>.fromOpaque(context).takeUnretainedValue()
    }

    @inline(__always) public func getContext<T: AnyObject>() -> T? {
        getContext() as? T
    }

    public func prepareForFree() {
        removeFromParent()
        removeAllChildren()
        clearContext()
    }

    public func freeSafely() {
        prepareForFree()
        YGNodeFree(self)
    }

    @inline(__always) public func markDirty() {
        YGNodeMarkDirty(self)
    }

    public func markDirtyIfAvailable() {
        if hasMeasureFunc {
            markDirty()
        }
        (getContext() as? any VAYogaLayout)?.setNeedsRelayout()
    }

    @inline(__always) public func setMeasureFunc(_ measureFunc: YGMeasureFunc) {
        YGNodeSetMeasureFunc(self, measureFunc)
    }

    @inline(__always) public func removeMeasureFunc() {
        YGNodeSetMeasureFunc(self, nil)
    }

    @inline(__always) public func removeFromParent() {
        parent?.remove(child: self)
    }

    @inline(__always) public func remove(child: YGNodeRef?) {
        YGNodeRemoveChild(self, child)
    }

    @inline(__always) public func removeAllChildren() {
        YGNodeRemoveAllChildren(self)
    }

    @inline(__always) public func getGhild(at index: Int) -> YGNodeRef? {
        YGNodeGetChild(self, index)
    }

    @inline(__always) public func insert(child: YGNodeRef, at index: Int) {
        YGNodeInsertChild(self, child, index)
    }
}

extension YGNodeRef? {
    public func hasSameChildren(sublayouts: [any VAYogaLayout]) -> Bool {
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

@MainActor public var baselineLabelFunc:
    @convention(c) (
        _ node: YGNodeRef?,
        _ width: Float,
        _ height: Float
    ) -> Float = { node, _, _ in
        guard let view: UILabel = node?.getContext() else {
            return 0
        }

        return Float(view.font.ascender)
    }
@MainActor public var baselineTextViewFunc:
    @convention(c) (
        _ node: YGNodeRef?,
        _ width: Float,
        _ height: Float
    ) -> Float = { node, _, _ in
        guard let view: UITextView = node?.getContext() else {
            return 0
        }

        return Float((view.font?.ascender ?? 0) + view.contentInset.top + view.textContainerInset.top)
    }
@MainActor public var baselineTextFieldFunc:
    @convention(c) (
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
@MainActor public var measureViewFunc:
    @convention(c) (
        _ node: YGNodeRef?,
        _ width: Float,
        _ widthMode: YGMeasureMode,
        _ height: Float,
        _ heightMode: YGMeasureMode
    ) -> YGSize = { (node: YGNodeRef?, width: Float, widthMode: YGMeasureMode, height: Float, heightMode: YGMeasureMode) in
        guard let layout = node?.getContext() as? any VAYogaLayout else {
            return .init(width: .zero, height: .zero)
        }

        let constrainedWidth = widthMode == .undefined ? .greatestFiniteMagnitude : width
        let constrainedHeight = heightMode == .undefined ? .greatestFiniteMagnitude : height
        var sizeThatFits: CGSize = .zero
        if layout.layoutType == .selfSizedView {
            sizeThatFits = layout.sizeThatFits(
                .init(
                    width: constrainedWidth.cg,
                    height: constrainedHeight.cg
                )
            )
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
