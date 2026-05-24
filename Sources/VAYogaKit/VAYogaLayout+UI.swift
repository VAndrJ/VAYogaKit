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
    var sublayoutViews: [UIView] = []

    func appendSubviews(sublayout: VAYogaLayout) {
        if let view = sublayout as? UIView {
            sublayoutViews.append(view)
        } else {
            sublayout.sublayouts.forEach(appendSubviews(sublayout:))
        }
    }

    root.sublayouts.forEach(appendSubviews(sublayout:))
    var viewsToDelete: [UIView] = []
    var viewToAppend: [UIView] = []
    for view in sublayoutViews {
        if !root.subviews.contains(view) {
            viewToAppend.append(view)
        }
    }
    for view in root.subviews {
        if !sublayoutViews.contains(view) {
            viewsToDelete.append(view)
        }
    }
    viewsToDelete.forEach { $0.removeFromSuperview() }
    viewToAppend.forEach { root.addSubview($0) }
}

extension VAYogaLayout where Self: UIView {
    public func flattenLayoutIfNeeded(in root: UIView) {
        let layout = self.layout
        if layout !== self {
            sublayouts = [layout]
        }
        var sublayoutViews: [UIView] = []

        func appendSubviews(sublayout: VAYogaLayout) {
            if let view = sublayout as? UIView {
                sublayoutViews.append(view)
            } else {
                sublayout.sublayouts.forEach(appendSubviews(sublayout:))
            }
        }

        sublayouts.forEach(appendSubviews(sublayout:))
        var viewsToDelete: [UIView] = []
        var viewToAppend: [UIView] = []
        for view in sublayoutViews {
            if !root.subviews.contains(view) {
                viewToAppend.append(view)
            }
        }
        for view in root.subviews {
            if !sublayoutViews.contains(view) {
                viewsToDelete.append(view)
            }
        }
        viewsToDelete.forEach { $0.removeFromSuperview() }
        viewToAppend.forEach { root.addSubview($0) }
    }

    public func SafeArea(edges: VASafeAreaEdge = .all, _ sublayout: () -> VAYogaLayout) -> Self {
        applySafeArea(edges: edges)
        sublayouts = [sublayout()]

        return self
    }

    public func SafeArea(edgesToIgnore: VASafeAreaEdge, _ sublayout: () -> VAYogaLayout) -> Self {
        applySafeArea(edges: .all.subtracting(edgesToIgnore))
        sublayouts = [sublayout()]

        return self
    }

    private func applySafeArea(edges: VASafeAreaEdge) {
        node.paddingTop = edges.contains(.top) ? .point(safeAreaInsets.top) : .zero
        node.paddingLeft = edges.contains(.left) ? .point(safeAreaInsets.left) : .zero
        node.paddingBottom = edges.contains(.bottom) ? .point(safeAreaInsets.bottom) : .zero
        node.paddingRight = edges.contains(.right) ? .point(safeAreaInsets.right) : .zero
    }
}
