//
//  VAYogaView.swift
//  
//
//  Created by VAndrJ on 27.04.2024.
//

import UIKit
import yoga

open class VAYogaView: UIView, VAYogaLayout {
    public let layoutType: VAYogaLayoutType
    public var node: YGNodeRef!
    public var sublayouts: [any VAYogaLayout] = []
    open var layout: any VAYogaLayout { self }

    public init(layoutType: VAYogaLayoutType) {
        self.layoutType = layoutType

        super.init(frame: .init(x: 0, y: 0, width: 240, height: 128))

        self.node = .new(for: self)

        if layoutType != .container {
            flattenLayoutIfNeeded(in: self)
        }
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func layoutSubviews() {
        if layoutType != .container {
            flattenLayoutIfNeeded(in: self)
        }

        super.layoutSubviews()

        if layoutType == .root {
            layout(mode: .fitContainer)
        }
    }

    deinit {
        YGNodeFree(node)
    }
}

