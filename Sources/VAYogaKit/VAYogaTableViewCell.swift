//
//  VAYogaTableViewCell.swift
//
//
//  Created by VAndrJ on 28.04.2024.
//

import UIKit
import yoga

open class VAYogaTableViewCell: UITableViewCell, VAYogaLayout {
    public var layoutType: VAYogaLayoutType = .containerView
    public var node: YGNodeRef!
    public var sublayouts: [any VAYogaLayout] = []
    open var layout: any VAYogaLayout { self }
    public var isDirty = true

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.node = .new(for: self)
        flattenLayoutIfNeeded(in: contentView)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setNeedsUpdateLayout() {
        isDirty = true
        var parent = superview
        while parent != nil {
            if let parent = parent as? VAYogaTableView {
                parent.setNeedsUpdateLayout()

                return
            }
            parent = parent?.superview
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        guard isDirty else { return }

        flattenLayoutIfNeeded(in: contentView)
        applyLayoutToTableCellHierarchy(width: contentView.frame.width) { height in
            frame.size.height = height
        }
        isDirty = false
    }

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        flattenLayoutIfNeeded(in: contentView)
        applyLayoutToTableCellHierarchy(width: contentView.frame.width) { height in
            frame.size.height = height
        }
        isDirty = false

        return frame.size
    }

    deinit {
        YGNodeFree(node)
    }
}
