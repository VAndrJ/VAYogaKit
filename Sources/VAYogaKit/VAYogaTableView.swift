//
//  VAYogaTableView.swift
//  
//
//  Created by VAndrJ on 28.04.2024.
//

import UIKit
import yoga

open class VAYogaTableView: UITableView, VAYogaLayout {
    public var layoutType: VAYogaLayoutType = .view
    public var node: YGNodeRef!
    public var sublayouts: [any VAYogaLayout] = []
    open var layout: any VAYogaLayout { self }
    public var isDirty = false
    public var shouldAnimateContentChange = true

    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        self.node = .new(for: self)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setNeedsUpdateLayout() {
        if shouldAnimateContentChange {
            performBatchUpdates {}
        } else {
            UIView.performWithoutAnimation {
                performBatchUpdates {}
            }
        }
    }

    deinit {
        YGNodeFree(node)
    }
}
