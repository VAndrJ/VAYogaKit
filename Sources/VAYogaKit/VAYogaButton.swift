//
//  VAYogaButton.swift
//  
//
//  Created by VAndrJ on 01.05.2024.
//

import UIKit
import yoga

open class VAYogaButton: UIButton, VAYogaLayout {
    public let layoutType: VAYogaLayoutType = .selfSizedView
    public var node: YGNodeRef!
    public var sublayouts: [any VAYogaLayout] = []
    public var layout: any VAYogaLayout { self }
    public var isDirty = false

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
