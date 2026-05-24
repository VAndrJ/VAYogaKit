//
//  VAYogaScrollView.swift
//
//
//  Created by VAndrJ on 29.04.2024.
//

import UIKit
import yoga

public struct VAYogaScrollableDirection: RawRepresentable, OptionSet, Sendable {
    public static let vertical = VAYogaScrollableDirection(rawValue: 1 << 0)
    public static let horizontal = VAYogaScrollableDirection(rawValue: 1 << 1)
    public static let all: VAYogaScrollableDirection = [.vertical, .horizontal]

    public var rawValue: UInt8

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
}

open class VAYogaScrollView: UIScrollView, VAYogaLayout {
    public var layoutType: VAYogaLayoutType = .containerView
    public var node: YGNodeRef!
    public var sublayouts: [any VAYogaLayout] = []
    open var layout: any VAYogaLayout { layoutBlock?() ?? contentView }
    public let contentView = VAYogaView(layoutType: .contentView)
    public var scrollableDirections: VAYogaScrollableDirection {
        didSet {
            node.markDirtyIfAvailable()
            setNeedsUpdateLayout()
        }
    }
    public var layoutBlock: (() -> (any VAYogaLayout)?)?
    public var isDirty = true
    private var lastLayoutMetrics: LayoutMetrics?

    public init(scrollableDirections: VAYogaScrollableDirection) {
        self.scrollableDirections = scrollableDirections

        super.init(frame: .init(x: 0, y: 0, width: 240, height: 128))

        self.node = .new(for: self)
        addSubview(contentView)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if previousTraitCollection?.horizontalSizeClass != traitCollection.horizontalSizeClass
            || previousTraitCollection?.verticalSizeClass != traitCollection.verticalSizeClass
        {
            setNeedsUpdateLayout()
        }
    }

    open override func adjustedContentInsetDidChange() {
        super.adjustedContentInsetDidChange()

        setNeedsLayout()
    }

    open override func safeAreaInsetsDidChange() {
        super.safeAreaInsetsDidChange()

        setNeedsLayout()
    }

    public func setNeedsUpdateLayout() {
        isDirty = true
        setNeedsLayout()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        let metrics = LayoutMetrics(scrollView: self)
        guard isDirty || metrics != lastLayoutMetrics else { return }

        flattenIfNeeded(layout: layout, in: contentView)
        contentView.applyLayoutToScrollHierarchy(
            size: metrics.layoutSize,
            scrollableDirections: scrollableDirections
        ) {
            contentView.frame.size = $0
            contentSize = $0
        }
        lastLayoutMetrics = metrics
        isDirty = false
    }

    isolated deinit {
        node.freeSafely()
    }
}

private struct LayoutMetrics: Equatable {
    let boundsSize: CGSize
    let contentInset: UIEdgeInsets
    let adjustedContentInset: UIEdgeInsets
    let safeAreaInsets: UIEdgeInsets
    let scrollableDirections: VAYogaScrollableDirection

    init(scrollView: VAYogaScrollView) {
        boundsSize = scrollView.bounds.size
        contentInset = scrollView.contentInset
        adjustedContentInset = scrollView.adjustedContentInset
        safeAreaInsets = scrollView.safeAreaInsets
        scrollableDirections = scrollView.scrollableDirections
    }

    var layoutSize: CGSize {
        .init(
            width: max(0, boundsSize.width - adjustedContentInset.left - adjustedContentInset.right),
            height: max(0, boundsSize.height - adjustedContentInset.top - adjustedContentInset.bottom)
        )
    }
}
