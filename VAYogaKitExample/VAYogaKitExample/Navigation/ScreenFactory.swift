//
//  ScreenFactory.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 28.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit
import VANavigator

class ScreenFactory: NavigatorScreenFactory {

    func assembleScreen(identity: any NavigationIdentity, navigator: Navigator) -> UIViewController {
        switch identity {
        case let identity as BaseNavigationIdentity:
            BaseNavigationController(rootViewController: assembleScreen(identity: identity.child, navigator: navigator).apply {
                $0.navigationIdentity = identity.child
            })
        case _ as MainScreenNavigationIdentity:
            BaseViewController(view: MainScreenView(viewModel: .init(context: .init(
                navigation: .init(navigate: navigator ?> {
                    $0.navigate(destination: .identity($1), strategy: .push())
                })
            ))))
        default:
            fatalError("Not implemented")
        }
    }
}
