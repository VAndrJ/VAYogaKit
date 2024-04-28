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

    public init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(
            frame: .init(x: 0, y: 0, width: 240, height: 128),
            collectionViewLayout: layout
        )

        self.node = .new(for: self)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
