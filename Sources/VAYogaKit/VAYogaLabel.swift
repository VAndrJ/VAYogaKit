//
//  VAYogaLabel.swift
//
//
//  Created by VAndrJ on 28.04.2024.
//

import UIKit
import yoga

open class VAYogaLabel: UILabel, VAYogaLayout {
    public let layoutType: VAYogaLayoutType = .selfSizedView
    public var node: YGNodeRef!
    public var sublayouts: [any VAYogaLayout] = []
    public var layout: any VAYogaLayout { self }

    open override var text: String? {
        get { super.text }
        set {
            super.text = newValue
            node.markDirtyIfAvailable()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.node = .new(for: self)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        YGNodeFree(node)
    }
}
