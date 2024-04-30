//
//  VAYogaLayout+Components.swift
//
//
//  Created by VAndrJ on 28.04.2024.
//

import UIKit
import yoga

open class Column: VAYogaLayout {
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

open class Row: VAYogaLayout {
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

public extension VAYogaLayout {

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
    func minSized(_ size: CGSize) -> Self {
        node.minWidth = .point(size.width)
        node.minHeight = .point(size.height)

        return self
    }

    @MainActor
    @discardableResult
    func flex(
        shrink: Float? = nil,
        grow: Float? = nil,
        basis: YGValue? = nil
    ) -> Self {
        if let shrink {
            node.flexShrink = shrink
        }
        if let grow {
            node.flexGrow = grow
        }
        if let basis {
            node.flexBasis = basis
        }

        return self
    }
}
