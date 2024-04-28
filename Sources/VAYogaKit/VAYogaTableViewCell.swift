//
//  VAYogaTableViewCell.swift
//
//
//  Created by VAndrJ on 28.04.2024.
//

import UIKit
import yoga

class VAYogaTableViewCell: UITableViewCell, VAYogaLayout {
    var layoutType: VAYogaLayoutType = .container
    var node: YGNodeRef!
    var sublayouts: [any VAYogaLayout] = []
    var layout: any VAYogaLayout { self }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.node = .new(for: self)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        flattenLayoutIfNeeded(in: contentView)
        layout(mode: .adjustHeight)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        flattenLayoutIfNeeded(in: contentView)
        layout(mode: .adjustHeight)

        return frame.size
    }
}
