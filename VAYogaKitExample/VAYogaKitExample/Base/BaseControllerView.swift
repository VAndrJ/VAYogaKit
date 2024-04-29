//
//  BaseControllerView.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 27.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit
import VAYogaKit

class BaseControllerView: VAYogaView, ControllerView {
    weak var controller: UIViewController?

    init() {
        super.init(layoutType: .root)
    }

    func controllerInitialized(_ controller: UIViewController) {
        self.controller = controller
    }

    func viewDidLoad() {
        addElements()
        configure()
        bind()
    }

    func addElements() {}

    func configure() {}

    func bind() {}
}
