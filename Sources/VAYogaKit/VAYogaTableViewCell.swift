//
//  VAYogaTableViewCell.swift
//
//
//  Created by VAndrJ on 28.04.2024.
//

import UIKit
import yoga

open class VAYogaTableViewCell: UITableViewCell, VAYogaLayout {
    public var layoutType: VAYogaLayoutType = .container
    public var node: YGNodeRef!
    public var sublayouts: [any VAYogaLayout] = []
    open var layout: any VAYogaLayout { self }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.node = .new(for: self)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        flattenLayoutIfNeeded(in: contentView)
        layout(mode: .adjustHeight)
    }

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        flattenLayoutIfNeeded(in: contentView)
        layout(mode: .adjustHeight)

        return frame.size
    }
}
