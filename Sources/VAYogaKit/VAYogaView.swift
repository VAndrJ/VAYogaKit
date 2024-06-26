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
    public var isDirty = false

    public init(layoutType: VAYogaLayoutType = .view) {
        self.layoutType = layoutType

        super.init(frame: .init(x: 0, y: 0, width: 240, height: 128))

        self.node = .new(for: self)

        flattenLayout()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        flattenLayout()
        if layoutType == .root {
            layout(mode: .fitContainer)
        }
    }

    private func flattenLayout() {
        if [.view, .root].contains(layoutType)  {
            flattenLayoutIfNeeded(in: self)
        }
    }

    deinit {
        YGNodeFree(node)
    }
}

