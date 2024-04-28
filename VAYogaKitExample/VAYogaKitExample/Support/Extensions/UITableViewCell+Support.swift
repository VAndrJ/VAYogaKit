//
//  UITableViewCell+Support.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 28.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit

extension UITableViewCell: VAIdentifiable {}

class TableCellViewModel<Cell: UITableViewCell & VAIdentifiable>: AnyTableCellViewModel {
    override class var cellType: (UITableViewCell & VAIdentifiable).Type { Cell.self }

    override func configure(cell: UITableViewCell) {
        configure(cell: cell as! Cell)
    }

    func configure(cell: Cell) {}
}

@MainActor
class AnyTableCellViewModel: Equatable {
    nonisolated static func == (lhs: AnyTableCellViewModel, rhs: AnyTableCellViewModel) -> Bool {
        type(of: lhs) == type(of: rhs) && lhs.isEqual(to: rhs)
    }

    class var cellType: (UITableViewCell & VAIdentifiable).Type { fatalError() }

    var cellType: (UITableViewCell & VAIdentifiable).Type { Self.cellType }

    func configure(cell: UITableViewCell) {}

    nonisolated func isEqual(to other: AnyTableCellViewModel) -> Bool {
        ObjectIdentifier(self) == ObjectIdentifier(other)
    }
}
