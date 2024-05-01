//
//  MainTableCellViewModel.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 29.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import Foundation

class MainTableCellViewModel: SpecializedCellViewModel<MainTableViewCell, MainCollectionViewCell> {
    let title: String
    let description: String
    let destination: NavigationIdentity

    init(title: String, description: String, destination: NavigationIdentity) {
        self.title = title
        self.description = description
        self.destination = destination
    }

    override func configure(cell: MainTableViewCell) {
        cell.configure(title: title, description: description)
    }

    override func configure(cell: MainCollectionViewCell) {
        cell.configure(title: title, description: description)
    }
}
