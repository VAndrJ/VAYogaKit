//
//  VAYogaScrollView.swift
//
//
//  Created by VAndrJ on 29.04.2024.
//

import UIKit
import yoga

public struct VAYogaScrollableDirection: RawRepresentable, OptionSet, Sendable {
    @MainActor public static let vertical = VAYogaScrollableDirection(rawValue: 1 << 0)
    @MainActor public static let horizontal = VAYogaScrollableDirection(rawValue: 1 << 1)
    @MainActor public static let all: VAYogaScrollableDirection = [.vertical, .horizontal]

    public var rawValue: UInt8

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
}

open class VAYogaScrollView: UIScrollView, VAYogaLayout {
    public var layoutType: VAYogaLayoutType = .containerView
    public var node: YGNodeRef!
    public var sublayouts: [any VAYogaLayout] = []
    public var layout: any VAYogaLayout { layoutBlock?() ?? contentView }
    public let contentView = VAYogaView(layoutType: .contentView)
    public var scrollableDirections: VAYogaScrollableDirection {
        didSet { 
            node.markDirtyIfAvailable()
            setNeedsUpdateLayout()
        }
    }
    public var layoutBlock: (() -> (any VAYogaLayout)?)?
    public var isDirty = true

    public init(scrollableDirections: VAYogaScrollableDirection) {
        self.scrollableDirections = scrollableDirections

        super.init(frame: .init(x: 0, y: 0, width: 240, height: 128))

        self.node = .new(for: self)
        addSubview(contentView)
        flattenIfNeeded(layout: layout, in: contentView)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if previousTraitCollection?.horizontalSizeClass != traitCollection.horizontalSizeClass ||
            previousTraitCollection?.verticalSizeClass != traitCollection.verticalSizeClass {
            setNeedsUpdateLayout()
        }
    }

    public func setNeedsUpdateLayout() {
        isDirty = true
        setNeedsLayout()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        guard isDirty else { return }

        flattenIfNeeded(layout: layout, in: contentView)
        contentView.applyLayoutToScrollHierarchy(
            size: frame.size,
            scrollableDirections: scrollableDirections
        ) {
            contentView.frame.size = $0
            contentSize = $0
        }
        isDirty = false
    }

    deinit {
        YGNodeFree(node)
    }
}
