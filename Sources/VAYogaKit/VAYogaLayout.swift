//
//  VAYogaLayout.swift
//
//
//  Created by VAndrJ on 26.04.2024.
//

import UIKit
import yoga

public protocol VAYogaLayout: AnyObject {
    @MainActor var layoutType: VAYogaLayoutType { get }
    @MainActor var node: YGNodeRef! { get set }
    @MainActor var sublayouts: [any VAYogaLayout] { get set }

    @MainActor
    func sizeThatFits(_ size: CGSize) -> CGSize
    @MainActor
    func setNeedsLayout()
}

public extension VAYogaLayout {

    @MainActor
    func setNeedsRelayout() {
        if layoutType == .root || layoutType == .container {
            setNeedsLayout()
        } else {
            let parent: AnyObject? = node?.parent?.getContext()
            (parent as? VAYogaLayout)?.setNeedsRelayout()
        }
    }
}

public enum VAYogaLayoutType {
    case layout
    case view
    case root
    case container
    case selfSizedView
}

extension VAYogaLayout {
    @MainActor public var isLeaf: Bool { sublayouts.isEmpty }
}
