//
//  RelativeScreenView.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 01.05.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit
import VAYogaKit
import VAYogaKitMacro
import yoga

struct RelativeScreenNavigationIdentity: DefaultNavigationIdentity {}

final class RelativeScreenView: BaseControllerView {
    private let changeHorizontalPositionButton = BaseButton(title: "Change horizontal positioning")
    private let changeVerticalPositionButton = BaseButton(title: "Change vertical positioning")
    private lazy var positionLabel = VAYogaLabel().apply {
        $0.numberOfLines = 0
    }
    private let backgroundView = VAYogaView().apply {
        $0.backgroundColor = .systemGray4
    }
    private let exampleView = FrameChangeAnimationView().apply {
        $0.backgroundColor = .systemOrange
    }
    @Layout @Published private var horizontal: YGAlign = .flexStart
    @Layout @Published private var vertical: YGJustify = .flexStart

    override func configureLayout() {
        positionLabel
            .margin(.vertical(16))
        backgroundView
            .aspect(1)
        exampleView
            .sized(.init(same: 44))
    }

    override var layout: any VAYogaLayout {
        SafeArea {
            Column(cross: .stretch) {
                changeHorizontalPositionButton
                changeVerticalPositionButton
                positionLabel
                Column(cross: .stretch) {
                    backgroundView
                    exampleView
                        .relatively(
                            horizontal: horizontal,
                            vertical: vertical
                        )
                }
            }
            .margin(.all(16))
        }
    }

    override func configure() {
        backgroundColor = .systemBackground
    }

    override func bind() {
        changeHorizontalPositionButton.onTap = self ?> { $0.horizontal.toggle() }
        changeVerticalPositionButton.onTap = self ?> { $0.vertical.toggle() }
        $horizontal.map(\.title)
            .combineLatest($vertical.map(\.title), { .some("Horizontal: \($0)\nVertical: \($1)") })
            .assign(to: \.text, on: positionLabel)
            .store(in: &bag)
    }
}

extension YGAlign {
    var toggled: YGAlign {
        switch self {
        case .flexStart: .center
        case .center: .flexEnd
        default: .flexStart
        }
    }

    mutating func toggle() {
        self = toggled
    }
}

extension YGJustify {
    var toggled: YGJustify {
        switch self {
        case .flexStart: .center
        case .center: .flexEnd
        default: .flexStart
        }
    }

    mutating func toggle() {
        self = toggled
    }
}
