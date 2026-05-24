//
//  VAYogaLayout+UI.swift
//
//
//  Created by VAndrJ on 28.04.2024.
//

import UIKit

func flattenIfNeeded(layout: VAYogaLayout, in root: UIView & VAYogaLayout) {
    if layout !== root {
        root.sublayouts = [layout]
    }

    syncSubviews(flattenedSubviews(from: root.sublayouts), in: root)
}

extension VAYogaLayout where Self: UIView {
    public func flattenLayoutIfNeeded(in root: UIView) {
        let layout = self.layout
        if layout !== self {
            sublayouts = [layout]
        }

        syncSubviews(flattenedSubviews(from: sublayouts), in: root)
    }

    public func SafeArea(edges: VASafeAreaEdge = .all, _ sublayout: () -> VAYogaLayout) -> Self {
        if edges.contains(.top) {
            node.paddingTop = .point(safeAreaInsets.top)
        }
        if edges.contains(.left) {
            node.paddingLeft = .point(safeAreaInsets.left)
        }
        if edges.contains(.bottom) {
            node.paddingBottom = .point(safeAreaInsets.bottom)
        }
        if edges.contains(.right) {
            node.paddingRight = .point(safeAreaInsets.right)
        }
        sublayouts = [sublayout()]

        return self
    }

    public func SafeArea(edgesToIgnore: VASafeAreaEdge, _ sublayout: () -> VAYogaLayout) -> Self {
        if !edgesToIgnore.contains(.top) {
            node.paddingTop = .point(safeAreaInsets.top)
        }
        if !edgesToIgnore.contains(.left) {
            node.paddingLeft = .point(safeAreaInsets.left)
        }
        if !edgesToIgnore.contains(.bottom) {
            node.paddingBottom = .point(safeAreaInsets.bottom)
        }
        if !edgesToIgnore.contains(.right) {
            node.paddingRight = .point(safeAreaInsets.right)
        }
        sublayouts = [sublayout()]

        return self
    }
}

private func flattenedSubviews(from sublayouts: [any VAYogaLayout]) -> [UIView] {
    var subviews: [UIView] = []

    func appendSubviews(sublayout: any VAYogaLayout) {
        if let view = sublayout as? UIView {
            subviews.append(view)
        } else {
            sublayout.sublayouts.forEach(appendSubviews(sublayout:))
        }
    }

    sublayouts.forEach(appendSubviews(sublayout:))

    return subviews
}

private func syncSubviews(_ desiredSubviews: [UIView], in root: UIView) {
    root.subviews
        .filter { subview in
            !desiredSubviews.contains { desiredSubview in
                desiredSubview === subview
            }
        }
        .forEach { $0.removeFromSuperview() }

    for (index, subview) in desiredSubviews.enumerated() {
        if root.subviews.indices.contains(index), root.subviews[index] === subview {
            continue
        }

        root.insertSubview(subview, at: min(index, root.subviews.count))
    }
}
