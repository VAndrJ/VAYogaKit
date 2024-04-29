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
    public var layoutType: VAYogaLayoutType = .container
    public var node: YGNodeRef!
    public var sublayouts: [any VAYogaLayout] = []
    public var layout: any VAYogaLayout { self }
    public let contentView = UIView()
    public var scrollableDirections: VAYogaScrollableDirection {
        didSet { node.markDirtyIfAvailable() }
    }

    public init(scrollableDirections: VAYogaScrollableDirection = .vertical) {
        self.scrollableDirections = scrollableDirections

        super.init(frame: .init(x: 0, y: 0, width: 240, height: 128))

        self.node = .new(for: self)
        addSubview(contentView)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        flattenLayoutIfNeeded(in: contentView)
        applyLayoutToScrollHierarchy(size: frame.size, scrollableDirections: scrollableDirections) {
            contentView.frame.size = $0
        }
    }
}
