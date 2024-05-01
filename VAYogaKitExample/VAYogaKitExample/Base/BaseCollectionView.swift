//
//  BaseCollectionView.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 29.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit
import VAYogaKit
import Differ
import Combine

class BaseCollectionView<Item: AnyCellViewModel>: VAYogaCollectionView, @unchecked Sendable {
    private var collectionDataSourceDelegate: CollectionDataSourceDelegate<Item>!
    private var publisher: AnyPublisher<[[Item]], Never> { listData.map { [$0] }.eraseToAnyPublisher() }
    private let listData: Published<[Item]>.Publisher

    init(
        listData: Published<[Item]>.Publisher,
        usedCells: [(UICollectionViewCell & VAIdentifiable).Type],
        onSelect: ((Item) -> Void)? = nil
    ) {
        self.listData = listData
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        super.init(frame: .zero, collectionViewLayout: layout)

        usedCells.forEach { register($0) }
        self.collectionDataSourceDelegate = CollectionDataSourceDelegate<Item>(
            collectionView: self,
            listData: publisher,
            onSelect: onSelect
        )
    }
}

class CollectionDataSourceDelegate<Item: AnyCellViewModel>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var data: [[Item]] = []

    private weak var collectionView: UICollectionView?
    private var bag: Set<AnyCancellable> = []
    private var onSelect: ((Item) -> Void)?

    init(
        collectionView: UICollectionView,
        listData: AnyPublisher<[[Item]], Never>,
        onSelect: ((Item) -> Void)? = nil
    ) {
        self.onSelect = onSelect
        self.collectionView = collectionView
        self.data = []

        super.init()

        collectionView.dataSource = self
        collectionView.delegate = self
        listData
            .sink(receiveValue: { [weak self] newData in
                guard let self else { return }

                self.collectionView?.animateItemAndSectionChanges(
                    oldData: data,
                    newData: newData,
                    updateData: { self.data = newData }
                )
            })
            .store(in: &bag)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        data.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        data[section].count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cellData = data[indexPath.section][indexPath.row]

        return collectionView.dequeue(cellData.collectionCellType, for: indexPath) {
            cellData.configure(cell: $0)
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        onSelect?(data[indexPath.section][indexPath.row])
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.frame.width / 2).rounded(.down) - 4

        return .init(same: width)
    }
}
