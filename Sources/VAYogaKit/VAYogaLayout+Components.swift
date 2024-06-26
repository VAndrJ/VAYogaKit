//
//  VAYogaLayout+Components.swift
//
//
//  Created by VAndrJ on 28.04.2024.
//

import UIKit
import yoga

public class Column: VAYogaLayout {
    public let layoutType: VAYogaLayoutType = .layout
    public var node: YGNodeRef!
    public var frame: CGRect = .zero
    public var sublayouts: [any VAYogaLayout]
    public var layout: any VAYogaLayout { self }
    public var isDirty = false

    @MainActor
    public init(
        spacing: Float = 0,
        main: YGJustify = .start,
        cross: YGAlign = .start,
        wrap: YGWrap = .noWrap,
        column: Float = 0,
        alignContent: YGAlign = .start,
        isReversed: Bool = false,
        @VAYogaLayoutBuilder content: () -> [VAYogaLayout]
    ) {
        self.sublayouts = content()

        node = .new(for: self)
        if isReversed {
            node.flexDirection = .columnReverse
        } else {
            node.flexDirection = .column
        }
        node.rowGap = spacing
        node.columnGap = spacing
        node.justifyContent = main
        node.alignItems = cross
        node.flexWrap = wrap
        node.alignContent = alignContent
    }

    public func sizeThatFits(_ size: CGSize) -> CGSize {
        .zero
    }

    public func setNeedsLayout() {}

    deinit {
        YGNodeFree(node)
    }
}

public class Row: VAYogaLayout {
    public let layoutType: VAYogaLayoutType = .layout
    public var node: YGNodeRef!
    public var frame: CGRect = .zero
    public var sublayouts: [any VAYogaLayout]
    public var layout: any VAYogaLayout { self }
    public var isDirty = false

    @MainActor
    public init(
        spacing: Float = 0,
        main: YGJustify = .start,
        cross: YGAlign = .start,
        wrap: YGWrap = .noWrap,
        row: Float = 0,
        alignContent: YGAlign = .start,
        isReversed: Bool = false,
        @VAYogaLayoutBuilder content: () -> [VAYogaLayout]
    ) {
        self.sublayouts = content()

        node = .new(for: self)
        if isReversed {
            node.flexDirection = .rowReverse
        } else {
            node.flexDirection = .row
        }
        node.columnGap = spacing
        node.rowGap = row
        node.justifyContent = main
        node.alignItems = cross
        node.flexWrap = wrap
        node.alignContent = alignContent
    }

    public func sizeThatFits(_ size: CGSize) -> CGSize {
        .zero
    }

    public func setNeedsLayout() {}

    deinit {
        YGNodeFree(node)
    }
}

public class RelativeLayout: VAYogaLayout {
    public let layoutType: VAYogaLayoutType = .layout
    public var node: YGNodeRef!
    public var frame: CGRect = .zero
    public var sublayouts: [any VAYogaLayout]
    public var layout: any VAYogaLayout { self }
    public var isDirty = false

    @MainActor
    public init(
        element: any VAYogaLayout,
        justify: YGJustify = .start,
        align: YGAlign = .start
    ) {
        self.sublayouts = [element]

        self.node = .new(for: self)
        node.positionType = .absolute
        node.width = .percent(100)
        node.height = .percent(100)
        node.justifyContent = justify
        node.alignItems = align
    }

    public func sizeThatFits(_ size: CGSize) -> CGSize {
        .zero
    }

    public func setNeedsLayout() {}

    deinit {
        YGNodeFree(node)
    }
}

public extension VAYogaLayout {

    @MainActor
    func relatively(
        horizontal: YGAlign = .start,
        vertical: YGJustify = .start
    ) -> any VAYogaLayout {
        RelativeLayout(
            element: self,
            justify: vertical,
            align: horizontal
        )
    }

    @MainActor
    func padding(_ paddings: VAIndentation...) -> Self {
        let insets = UIEdgeInsets(indentation: paddings)
        node.paddingTop = .point(insets.top)
        node.paddingLeft = .point(insets.left)
        node.paddingBottom = .point(insets.bottom)
        node.paddingRight = .point(insets.right)

        return self
    }

    @MainActor
    @discardableResult
    func margin(_ margins: VAIndentation...) -> Self {
        let insets = UIEdgeInsets(indentation: margins)
        node.marginTop = .point(insets.top)
        node.marginLeft = .point(insets.left)
        node.marginBottom = .point(insets.bottom)
        node.marginRight = .point(insets.right)

        return self
    }

    @MainActor
    @discardableResult
    func aspect(_ ratio: Float) -> Self {
        node.aspectRatio = ratio

        return self
    }

    @MainActor
    @discardableResult
    func sized(_ size: CGSize) -> Self {
        node.width = .point(size.width)
        node.height = .point(size.height)

        return self
    }

    @MainActor
    @discardableResult
    func sized(width: CGFloat, height: CGFloat) -> Self {
        node.width = .point(width)
        node.height = .point(height)

        return self
    }

    @MainActor
    @discardableResult
    func sized(height: CGFloat) -> Self {
        node.height = .point(height)

        return self
    }

    @MainActor
    @discardableResult
    func sized(width: CGFloat) -> Self {
        node.width = .point(width)

        return self
    }

    @MainActor
    @discardableResult
    func minSized(_ size: CGSize) -> Self {
        node.minWidth = .point(size.width)
        node.minHeight = .point(size.height)

        return self
    }

    @MainActor
    @discardableResult
    func flexBasis(_ value: YGValue) -> Self {
        node.flexBasis = value

        return self
    }

    @MainActor
    @discardableResult
    func flexShrink(_ value: Float) -> Self {
        node.flexShrink = value

        return self
    }

    @MainActor
    @discardableResult
    func flexGrow(_ value: Float) -> Self {
        node.flexGrow = value

        return self
    }
}
