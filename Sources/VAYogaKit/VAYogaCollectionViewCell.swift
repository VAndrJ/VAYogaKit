//
//  VAYogaCollectionViewCell.swift
//
//
//  Created by VAndrJ on 29.04.2024.
//

import UIKit
import yoga

open class VAYogaCollectionViewCell: UICollectionViewCell, VAYogaLayout {
    public var layoutType: VAYogaLayoutType = .containerView
    public var node: YGNodeRef!
    public var sublayouts: [any VAYogaLayout] = []
    open var layout: any VAYogaLayout { self }
    public var isDirty = true

    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.node = .new(for: self)
        flattenLayoutIfNeeded(in: contentView)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setNeedsUpdateLayout() {
        isDirty = true
        setNeedsLayout()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        guard isDirty else { return }

        calculateLayoutSize(size: contentView.bounds.size)
        isDirty = false
    }

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let calculatedSize = calculateLayoutSize(size: resolvedFittingSize(for: size))
        isDirty = false

        return calculatedSize
    }

    @discardableResult
    private func calculateLayoutSize(size: CGSize) -> CGSize {
        flattenLayoutIfNeeded(in: contentView)
        applyLayoutToCollectionCellHierarchy(size: size)

        return .init(width: node.widthValue, height: node.heightValue)
    }

    private func resolvedFittingSize(for size: CGSize) -> CGSize {
        return .init(
            width: size.width.validYogaConstraint(or: contentView.bounds.width),
            height: size.height.validYogaConstraint(or: contentView.bounds.height)
        )
    }

    isolated deinit {
        node.freeSafely()
    }
}

extension CGFloat {
    fileprivate func validYogaConstraint(or fallback: CGFloat) -> CGFloat {
        if isFinite && self > 0 && self < .greatestFiniteMagnitude {
            return self
        }

        if fallback.isFinite && fallback > 0 && fallback < .greatestFiniteMagnitude {
            return fallback
        }

        return .nan
    }
}
