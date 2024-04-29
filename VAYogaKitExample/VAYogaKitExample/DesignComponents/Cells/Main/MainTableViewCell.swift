//
//  MainTableViewCell.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 28.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit
import VAYogaKit

class MainTableViewCell: VAYogaTableViewCell {
    private let titleLabel = VAYogaLabel().apply {
        $0.numberOfLines = 0
        $0.font = .boldSystemFont(ofSize: 18)
    }
    private let descriptionLabel = VAYogaLabel().apply {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 15, weight: .light)
        $0.textColor = .secondaryLabel
    }

    func configure(title: String, description: String) {
        accessoryType = .disclosureIndicator
        titleLabel.text = title
        descriptionLabel.text = description
    }

    override var layout: any VAYogaLayout {
        Column(spacing: 4) {
            titleLabel
            descriptionLabel
        }
        .margin(.all(16))
    }
}

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
