//
//  MainCollectionViewCell.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 29.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit
import VAYogaKit

class MainCollectionViewCell: VAYogaCollectionViewCell {
    private let headerView = VAYogaView().apply {
        $0.backgroundColor = .systemGray4
        $0.flex(grow: 1)
    }
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
        titleLabel.text = title
        descriptionLabel.text = description
    }

    override var layout: any VAYogaLayout {
        Column(spacing: 8, cross: .stretch) {
            headerView
            Column(spacing: 4, main: .end, cross: .stretch) {
                titleLabel
                descriptionLabel
            }
            .margin(.all(8))
        }
        .flex(grow: 1)
    }
}
