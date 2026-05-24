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

        frame.size.height = calculateLayoutHeight(width: contentView.bounds.width)
        isDirty = false
    }

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let width = resolvedFittingWidth(for: size)
        let height = calculateLayoutHeight(width: width)
        isDirty = false

        return .init(width: width, height: height)
    }

    private func calculateLayoutHeight(width: CGFloat) -> CGFloat {
        var calculatedHeight: CGFloat = 0

        flattenLayoutIfNeeded(in: contentView)
        applyLayoutToTableCellHierarchy(width: width) { height in
            calculatedHeight = height
        }

        return calculatedHeight
    }

    private func resolvedFittingWidth(for size: CGSize) -> CGFloat {
        if size.width.isValidYogaConstraint {
            return size.width
        }
        if contentView.bounds.width.isValidYogaConstraint {
            return contentView.bounds.width
        }
        if bounds.width.isValidYogaConstraint {
            return bounds.width
        }

        return 0
    }

    isolated deinit {
        node.freeSafely()
    }
}

private extension CGFloat {
    var isValidYogaConstraint: Bool {
        isFinite && self > 0 && self < .greatestFiniteMagnitude
    }
}
