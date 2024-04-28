//
//  BaseScreenView.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 28.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit

class BaseScreenView<VM: ViewModel>: BaseControllerView, @unchecked Sendable {
    let viewModel: VM

    init(viewModel: VM) {
        self.viewModel = viewModel

        super.init()
    }
}

class BaseViewModel: NSObject, ViewModel, @unchecked Sendable {}

@MainActor
protocol ViewModel {}
