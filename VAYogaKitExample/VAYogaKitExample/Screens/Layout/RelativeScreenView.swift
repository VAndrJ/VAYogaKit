//
//  RelativeScreenView.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 01.05.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit
import VAYogaKit
import yoga

struct RelativeScreenNavigationIdentity: DefaultNavigationIdentity {}

final class RelativeScreenView: BaseControllerView {
    private let changeHorizontalPositionButton = VAYogaButton(type: .system)
    private let changeVerticalPositionButton = VAYogaButton(type: .system)
    private let positionLabel = VAYogaLabel()
}
