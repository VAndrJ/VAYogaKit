//
//  VAYogaCollectionViewCell.swift
//  
//
//  Created by VAndrJ on 29.04.2024.
//

import UIKit
import yoga

open class VAYogaCollectionViewCell: UICollectionViewCell, VAYogaLayout {
    public var layoutType: VAYogaLayoutType = .containerView
    public var node: YGNodeRef!
    public var sublayouts: [any VAYogaLayout] = []
    open var layout: any VAYogaLayout { self }
    public var isDirty = true

    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.node = .new(for: self)
        flattenLayoutIfNeeded(in: contentView)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setNeedsUpdateLayout() {
        isDirty = true
        setNeedsLayout()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        guard isDirty else { return }

        flattenLayoutIfNeeded(in: contentView)
        // TODO: - For different sizings
        applyLayoutToCollectionCellHierarchy(size: contentView.frame.size)
        isDirty = true
    }

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        flattenLayoutIfNeeded(in: contentView)
        applyLayoutToCollectionCellHierarchy(size: contentView.frame.size)
        isDirty = false

        return contentView.frame.size
    }

    deinit {
        YGNodeFree(node)
    }
}
