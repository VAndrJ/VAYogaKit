//
//  BaseTableView.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 28.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit
import VAYogaKit
import Differ
import Combine

class BaseTableView<Item: AnyCellViewModel>: VAYogaTableView, @unchecked Sendable {
    private var tableDataSourceDelegate: TableDataSourceDelegate<Item>!
    private var publisher: AnyPublisher<[[Item]], Never> { listData.map { [$0] }.eraseToAnyPublisher() }
    private let listData: Published<[Item]>.Publisher

    init(
        style: UITableView.Style = .plain,
        listData: Published<[Item]>.Publisher,
        onSelect: ((Item) -> Void)? = nil
    ) {
        self.listData = listData

        super.init(style: style)

        self.tableDataSourceDelegate = TableDataSourceDelegate<Item>(
            tableView: self,
            listData: publisher,
            onSelect: onSelect
        )
    }
}

class TableDataSourceDelegate<Item: AnyCellViewModel>: NSObject, UITableViewDataSource, UITableViewDelegate {
    var data: [[Item]] {
        didSet { tableView?.animateRowAndSectionChanges(oldData: oldValue, newData: data) }
    }

    private weak var tableView: UITableView?
    private var bag: Set<AnyCancellable> = []
    private var onSelect: ((Item) -> Void)?

    init(
        tableView: UITableView,
        listData: AnyPublisher<[[Item]], Never>,
        onSelect: ((Item) -> Void)? = nil
    ) {
        self.onSelect = onSelect
        self.tableView = tableView
        self.data = []

        super.init()

        listData
            .sink(receiveValue: self ?> { $0.data = $1 })
            .store(in: &bag)
        tableView.dataSource = self
        tableView.delegate = self
    }

    init(
        tableView: UITableView,
        data: [[Item]] = [],
        onSelect: ((Item) -> Void)? = nil
    ) {
        self.onSelect = onSelect
        self.tableView = tableView
        self.data = data

        super.init()

        tableView.dataSource = self
        tableView.delegate = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        data[section].count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cellData = data[indexPath.section][indexPath.row]

        return tableView.dequeue(cellData.tableCellType) {
            cellData.configure(cell: $0)
        }
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        onSelect?(data[indexPath.section][indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
