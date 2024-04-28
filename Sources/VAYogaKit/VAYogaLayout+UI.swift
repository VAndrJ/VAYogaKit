//
//  VAYogaLayout+UI.swift
//  
//
//  Created by VAndrJ on 28.04.2024.
//

import UIKit

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
}
