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

class BaseTableView<Item: AnyTableCellViewModel>: VAYogaTableView, @unchecked Sendable {
    private var tableDataSourceDelegate: TableDataSourceDelegate<Item>!
    private var publisher: AnyPublisher<[[Item]], Never> { listData.map { [$0] }.eraseToAnyPublisher() }
    private let listData: Published<[Item]>.Publisher

    init(
        style: UITableView.Style = .plain,
        listData: Published<[Item]>.Publisher
    ) {
        self.listData = listData

        super.init(style: style)

        configure()
    }

    func configure() {
        tableDataSourceDelegate = TableDataSourceDelegate<Item>(
            tableView: self,
            listData: publisher
        )
    }
}

class TableDataSourceDelegate<Item: AnyTableCellViewModel>: NSObject, UITableViewDataSource, UITableViewDelegate {
    var data: [[Item]] {
        didSet { tableView?.animateRowAndSectionChanges(oldData: oldValue, newData: data) }
    }

    private weak var tableView: UITableView?
    private var bag: Set<AnyCancellable> = []

    init(
        tableView: UITableView,
        listData: AnyPublisher<[[Item]], Never>
    ) {
        self.tableView = tableView
        self.data = []

        super.init()

        listData
            .sink(receiveValue: self ?> { $0.data = $1 })
            .store(in: &bag)
        tableView.dataSource = self
        tableView.delegate = self
    }

    init(tableView: UITableView, data: [[Item]] = []) {
        self.tableView = tableView
        self.data = data

        super.init()

        tableView.dataSource = self
        tableView.delegate = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = data[indexPath.section][indexPath.row]

        return tableView.dequeue(cellData.cellType) {
            cellData.configure(cell: $0)
        }
    }
}
