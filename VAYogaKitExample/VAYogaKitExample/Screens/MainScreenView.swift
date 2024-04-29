//
//  MainScreenView.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 28.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit
import VAYogaKit
import VAYogaKitMacro

struct MainScreenNavigationIdentity: DefaultNavigationIdentity {}

final class MainScreenView: BaseScreenView<MainScreenViewModel> {
    private lazy var tableView = BaseTableView(
        listData: viewModel.$listData,
        onSelect: viewModel ?> { $0.onSelect(cell: $1) }
    )
    private lazy var collectionView = BaseCollectionView(
        listData: viewModel.$listData,
        usedCells: [MainCollectionViewCell.self],
        onSelect: viewModel ?> { $0.onSelect(cell: $1) }
    )
    @Layout private var isGridView = false

    override var layout: any VAYogaLayout {
        SafeArea {
            if isGridView {
                collectionView
                    .flex(grow: 1)
            } else {
                tableView
                    .flex(grow: 1)
            }
        }
    }

    override func configure() {
        backgroundColor = .systemBackground
        controller?.title = "VAYogaKit examples"
        controller?.navigationItem.rightBarButtonItem = .init(
            image: UIImage(systemName: "pencil"),
            style: .plain,
            target: self,
            action: #selector(onToggleGrid)
        )
    }

    @objc private func onToggleGrid() {
        isGridView.toggle()
    }
}

final class MainScreenViewModel: BaseViewModel, UITableViewDelegate {
    struct Context {
        struct Navigation {
            let navigate: (_ identity: NavigationIdentity) -> Void
        }

        let navigation: Navigation
    }

    @Published var listData: [MainTableCellViewModel] = [
        .init(title: "Row", description: "Layout example", destination: RowScreenNavigationIdentity()),
        .init(title: "Column", description: "Layout example", destination: ColumnScreenNavigationIdentity()),
    ]

    let context: Context

    init(context: Context) {
        self.context = context
    }

    func onSelect(cell: MainTableCellViewModel) {
        context.navigation.navigate(cell.destination)
    }
}
