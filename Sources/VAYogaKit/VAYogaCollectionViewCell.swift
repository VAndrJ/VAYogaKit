//
//  VAYogaCollectionViewCell.swift
//  
//
//  Created by VAndrJ on 29.04.2024.
//

import UIKit
import yoga

open class VAYogaCollectionViewCell: UICollectionViewCell, VAYogaLayout {
    public var layoutType: VAYogaLayoutType = .container
    public var node: YGNodeRef!
    public var sublayouts: [any VAYogaLayout] = []
    open var layout: any VAYogaLayout { self }
    public var isDirty = false

    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.node = .new(for: self)
        flattenLayoutIfNeeded(in: contentView)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        flattenLayoutIfNeeded(in: contentView)

        super.layoutSubviews()

        // TODO: - For different sizings
        applyLayoutToCollectionCellHierarchy(size: contentView.frame.size)
    }

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        flattenLayoutIfNeeded(in: contentView)
        applyLayoutToCollectionCellHierarchy(size: contentView.frame.size)

        return contentView.frame.size
    }

    deinit {
        YGNodeFree(node)
    }
}
