//
//  UITableView+Support.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 28.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit

extension UITableView {

    func register<Cell: UITableViewCell & VAIdentifiable>(_ cell: Cell.Type) {
        register(cell, forCellReuseIdentifier: cell.identifier)
    }

    func dequeue<Cell: UITableViewCell & VAIdentifiable>(
        _ cell: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell {
        dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as! Cell
    }

    func dequeue<Cell: UITableViewCell & VAIdentifiable>(
        _ cell: Cell.Type,
        for indexPath: IndexPath,
        configure: (Cell) -> Void
    ) -> Cell {
        let cell = dequeue(cell, for: indexPath)
        configure(cell)

        return cell
    }

    func dequeue<Cell: UITableViewCell & VAIdentifiable>(_ cell: Cell.Type) -> Cell {
        if let cell = dequeueReusableCell(withIdentifier: cell.identifier) as? Cell {
            return cell
        } else {
            register(cell)

            return dequeue(cell)
        }
    }

    func dequeue<Cell: UITableViewCell & VAIdentifiable>(
        _ cell: Cell.Type,
        configure: (Cell) -> Void
    ) -> Cell {
        let cell = dequeue(cell)
        configure(cell)

        return cell
    }
}
