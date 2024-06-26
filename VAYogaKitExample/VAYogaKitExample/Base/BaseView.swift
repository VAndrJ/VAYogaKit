//
//  BaseView.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 27.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit
import VAYogaKit

class BaseView: VAYogaView {

    override init(layoutType: VAYogaLayoutType = .view) {
        super.init(layoutType: layoutType)

        configureLayout()
        addElements()
        configure()
        bind()
    }

    func configureLayout() {}

    func addElements() {}

    func configure() {}

    func bind() {}
}
