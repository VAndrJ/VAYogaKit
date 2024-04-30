//
//  RowScreenView.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 29.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit
import VAYogaKit
import yoga

struct RowScreenNavigationIdentity: DefaultNavigationIdentity {}

final class RowScreenView: BaseControllerView {
    private let scrollView = VAYogaScrollView(scrollableDirections: .vertical).apply {
        $0.alwaysBounceVertical = true
    }
    private let startStartExampleView = RowExampleView(main: .start, cross: .start)
    private let endStartExampleView = RowExampleView(main: .end, cross: .start)
    private let centerStartExampleView = RowExampleView(main: .center, cross: .start)
    private let spaceBetweenStartExampleView = RowExampleView(main: .spaceBetween, cross: .start)
    private let spaceAroundStartExampleView = RowExampleView(main: .spaceAround, cross: .start)
    private let spaceEventlyStartExampleView = RowExampleView(main: .spaceEvently, cross: .start)
    private let startEndExampleView = RowExampleView(main: .start, cross: .end)
    private let startCenterExampleView = RowExampleView(main: .start, cross: .center)

    override var layout: any VAYogaLayout {
        SafeArea {
            scrollView
                .flex(grow: 1)
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
        controller?.title = "Row layout example"
    }
}

private final class RowExampleView: BaseView {
    private lazy var titleLabel = VAYogaLabel().apply {
        $0.numberOfLines = 0
        $0.text = title
        $0.textColor = .label
    }
    private lazy var exampleViews = (1...4).map { index in
        VAYogaView().apply {
            $0.sized(getSize(index: index))
            $0.backgroundColor = .systemGray3
        }
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
            Row(spacing: 4, main: main, cross: cross) {
                exampleViews
            }
        }
    }

    override func configure() {
        backgroundColor = .systemBackground
    }

    private func getSize(index: Int) -> CGSize {
        switch (main, cross) {
        case (_, .end), (_, .center): .init(same: 9 * CGFloat(index))
        default: .init(same: 36)
        }
    }
}
