//
//  UICollectionView+Support.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 28.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit

extension UICollectionView {

    func register<Cell: UICollectionViewCell & VAIdentifiable>(_ cell: Cell.Type) {
        register(cell, forCellWithReuseIdentifier: cell.identifier)
    }

    func dequeue<Cell: UICollectionViewCell & VAIdentifiable>(
        _ cell: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell {
        dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as! Cell
    }
}
