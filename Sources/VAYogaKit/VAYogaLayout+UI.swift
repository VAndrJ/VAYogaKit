//
//  VAYogaLayout+UI.swift
//  
//
//  Created by VAndrJ on 28.04.2024.
//

import UIKit

@MainActor
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

public extension VAYogaLayout where Self: UIView {

    // TODO: - Layout caching?
    @MainActor
    func flattenLayoutIfNeeded(in root: UIView) {
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

    @MainActor
    func SafeArea(edges: VASafeAreaEdge = .all, _ sublayout: () -> VAYogaLayout) -> Self {
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

    @MainActor
    func SafeArea(edgesToIgnore: VASafeAreaEdge, _ sublayout: () -> VAYogaLayout) -> Self {
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
