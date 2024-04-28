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
