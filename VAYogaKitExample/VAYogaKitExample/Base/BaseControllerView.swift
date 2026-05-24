//
//  BaseControllerView.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 27.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import Combine
import UIKit
import VAYogaKit

class BaseControllerView: VAYogaView, ControllerView {
    weak var controller: UIViewController?
    var bag: Set<AnyCancellable> = []

    init() {
        super.init(layoutType: .root)

        configureLayout()
    }

    func controllerInitialized(_ controller: UIViewController) {
        self.controller = controller
    }

    func viewDidLoad() {
        addElements()
        configure()
        bind()
    }

    func configureLayout() {}

    func addElements() {}

    func configure() {}

    func bind() {}

    isolated deinit {
        debugLine(in: self)
    }
}
