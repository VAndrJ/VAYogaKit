//
//  UITableViewCell+Support.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 28.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit

extension UITableViewCell: VAIdentifiable {}

class SpecializedCellViewModel<TableCell: UITableViewCell & VAIdentifiable, CollectionCell: UICollectionViewCell & VAIdentifiable>: AnyTableCellViewModel {
    override class var tableCellType: UITableViewCell.Type { TableCell.self }
    override class var collectionCellType: UICollectionViewCell.Type { CollectionCell.self }

    override func configure(cell: UITableViewCell) {
        configure(cell: cell as! TableCell)
    }

    func configure(cell: TableCell) {}

    override func configure(cell: UICollectionViewCell) {
        configure(cell: cell as! CollectionCell)
    }

    func configure(cell: CollectionCell) {}
}

@MainActor
class AnyTableCellViewModel: CellViewModel<UITableViewCell, UICollectionViewCell> {

    func configure(cell: UITableViewCell) {}

    func configure(cell: UICollectionViewCell) {}
}

@MainActor
class CellViewModel<TableCell: AnyObject, CollectionCell: AnyObject>: Equatable {
    nonisolated static func == (lhs: CellViewModel, rhs: CellViewModel) -> Bool {
        type(of: lhs) == type(of: rhs) && lhs.isEqual(to: rhs)
    }

    class var tableCellType: TableCell.Type { fatalError("Override") }
    class var collectionCellType: CollectionCell.Type { fatalError("Override") }

    var tableCellType: TableCell.Type { Self.tableCellType }
    var collectionCellType: CollectionCell.Type { Self.collectionCellType }

    nonisolated func isEqual(to other: CellViewModel) -> Bool {
        ObjectIdentifier(self) == ObjectIdentifier(other)
    }
}
