//
//  BaseViewController.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 27.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit

@MainActor
protocol ControllerView: UIView {

    func controllerInitialized(_ controller: UIViewController)
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewIsAppearing(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}

extension ControllerView {

    func controllerInitialized(_ controller: UIViewController) {}

    func viewDidLoad() {}

    func viewWillAppear(_ animated: Bool) {}

    func viewIsAppearing(_ animated: Bool) {}

    func viewDidAppear(_ animated: Bool) {}

    func viewWillDisappear(_ animated: Bool) {}

    func viewDidDisappear(_ animated: Bool) {}
}

class BaseViewController<V: ControllerView>: UIViewController {
    let contentView: V

    init(view: V) {
        self.contentView = view

        super.init(nibName: nil, bundle: nil)

        view.controllerInitialized(self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        contentView.viewWillAppear(animated)
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)

        contentView.viewIsAppearing(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        contentView.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        contentView.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        contentView.viewDidDisappear(animated)
    }
}
