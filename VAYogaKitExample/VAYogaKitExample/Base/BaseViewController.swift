//
//  BaseViewController.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 27.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit

@MainActor
protocol ControllerView: UIView {}

class BaseViewController<V: ControllerView>: UIViewController {
    let contentView: V

    init(view: V) {
        self.contentView = view

        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }
}
