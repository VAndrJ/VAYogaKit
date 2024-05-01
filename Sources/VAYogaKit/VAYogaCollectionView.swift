//
//  VAYogaCollectionView.swift
//
//
//  Created by VAndrJ on 28.04.2024.
//

import UIKit
import yoga

open class VAYogaCollectionView: UICollectionView, VAYogaLayout {
    public let layoutType: VAYogaLayoutType = .view
    public var node: YGNodeRef!
    public var sublayouts: [any VAYogaLayout] = []
    open var layout: any VAYogaLayout { self }
    public var isDirty = false

    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)

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
