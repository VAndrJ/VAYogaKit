//
//  BaseNavigationController.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 29.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit

struct BaseNavigationIdentity: DefaultNavigationIdentity {
    let child: NavigationIdentity
}

class BaseNavigationController: UINavigationController {}
