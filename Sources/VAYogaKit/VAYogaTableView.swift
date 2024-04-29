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

    public init(style: UITableView.Style, estimatedRowHeight: CGFloat = 44) {
        super.init(frame: .init(x: 0, y: 0, width: 240, height: 128), style: style)

        self.node = .new(for: self)
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = estimatedRowHeight
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        YGNodeFree(node)
    }
}
