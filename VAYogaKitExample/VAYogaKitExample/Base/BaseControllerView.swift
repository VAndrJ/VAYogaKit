//
//  BaseControllerView.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 27.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit
import VAYogaKit

class BaseControllerView: BaseView, ControllerView {
    weak var controller: UIViewController?

    init() {
        super.init(layoutType: .root)
    }

    func controllerInitialized(_ controller: UIViewController) {
        self.controller = controller
    }
}
