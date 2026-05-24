//
//  ColumnScreenView.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 29.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit
import VAYogaKit
import yoga

struct ColumnScreenNavigationIdentity: DefaultNavigationIdentity {}

final class ColumnScreenView: BaseControllerView {
    private let scrollView = VAYogaScrollView(scrollableDirections: .vertical).apply {
        $0.alwaysBounceVertical = true
    }
    private let startStartExampleView = ColumnExampleView(main: .flexStart, cross: .flexStart)
    private let endStartExampleView = ColumnExampleView(main: .flexEnd, cross: .flexStart)
    private let centerStartExampleView = ColumnExampleView(main: .center, cross: .flexStart)
    private let spaceBetweenStartExampleView = ColumnExampleView(main: .spaceBetween, cross: .flexStart)
    private let spaceAroundStartExampleView = ColumnExampleView(main: .spaceAround, cross: .flexStart)
    private let spaceEventlyStartExampleView = ColumnExampleView(main: .spaceEvenly, cross: .flexStart)
    private let startEndExampleView = ColumnExampleView(main: .flexStart, cross: .flexEnd)
    private let startCenterExampleView = ColumnExampleView(main: .flexStart, cross: .center)

    override var layout: any VAYogaLayout {
        SafeArea {
            scrollView
                .flexGrow(1)
        }
    }

    var scrollLayout: any VAYogaLayout {
        Column(spacing: 16, cross: .stretch) {
            startStartExampleView
            endStartExampleView
            centerStartExampleView
            spaceBetweenStartExampleView
            spaceAroundStartExampleView
            spaceEventlyStartExampleView
            startEndExampleView
            startCenterExampleView
        }
    }

    override func configure() {
        backgroundColor = .tertiarySystemGroupedBackground
        scrollView.layoutBlock = self ?> { $0.scrollLayout }
        controller?.title = "Column layout example"
    }
}

private final class ColumnExampleView: BaseView {
    private lazy var titleLabel = VAYogaLabel().apply {
        $0.numberOfLines = 0
        $0.text = title
        $0.textColor = .label
    }
    private lazy var exampleViews = (1...3).map { index in
        VAYogaView().apply {
            $0.sized(getSize(index: index))
            $0.backgroundColor = .systemGray3
        }
    }
    private let measureView = VAYogaView().apply {
        $0.sized(width: 12, height: 150)
        $0.backgroundColor = .systemGray
    }
    private var title: String { "Main axis: \(main.title)\nCross axis: \(cross.title)" }
    private let main: YGJustify
    private let cross: YGAlign

    init(main: YGJustify, cross: YGAlign) {
        self.main = main
        self.cross = cross

        super.init()
    }

    override var layout: any VAYogaLayout {
        Column(cross: .stretch) {
            titleLabel
                .margin(.all(8))
            Row(spacing: 16, cross: .stretch) {
                measureView
                Column(spacing: 4, main: main, cross: cross) {
                    exampleViews
                }
            }
        }
    }

    override func configure() {
        backgroundColor = .systemBackground
    }

    private func getSize(index: Int) -> CGSize {
        switch (main, cross) {
        case (_, .flexEnd), (_, .center): .init(same: 8 * CGFloat(index))
        default: .init(same: 24)
        }
    }
}
