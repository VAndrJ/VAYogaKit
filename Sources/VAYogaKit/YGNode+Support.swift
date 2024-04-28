//
//  YGNode+Support.swift
//
//
//  Created by Volodymyr Andriienko on 25.04.2024.
//

import UIKit
import yoga

public extension YGNodeRef {

    @MainActor
    static func new(for object: AnyObject) -> YGNodeRef {
        let node: YGNodeRef! = YGNodeNewWithConfig(VAYogaConfig.globalConfig)
        YGNodeSetContext(node, Unmanaged.passUnretained(object).toOpaque())

        return node
    }

    var childCount: Int { YGNodeGetChildCount(self) }
    var parent: YGNodeRef? { YGNodeGetParent(self) }
    var hasBaselineFunc: Bool { YGNodeHasBaselineFunc(self) }
    var hasMeasureFunc: Bool { YGNodeHasMeasureFunc(self) }

    @inline(__always) func setMeasure(_ measureFunc: YGMeasureFunc) {
        YGNodeSetMeasureFunc(self, measureFunc)
    }

    @inline(__always) func removeFromParent() {
        parent?.remove(child: self)
    }

    @inline(__always) func remove(child: YGNodeRef?) {
        YGNodeRemoveChild(self, child)
    }

    @inline(__always) func removeAllChildren() {
        YGNodeRemoveAllChildren(self)
    }

    @inline(__always) func getGhild(at index: Int) -> YGNodeRef? {
        YGNodeGetChild(self, index)
    }

    @inline(__always) func insert(child: YGNodeRef, at index: Int) {
        YGNodeInsertChild(self, child, index)
    }
}
@MainActor public var baselineLabelFunc: @convention(c) (
    _ node: YGNodeRef?,
    _ width: Float,
    _ height: Float
) -> Float = { node, _, _ in
    guard let view: UILabel = node?.getContext() else {
        return 0
    }

    return Float(view.font.ascender)
}
@MainActor public var baselineTextViewFunc: @convention(c) (
    _ node: YGNodeRef?,
    _ width: Float,
    _ height: Float
) -> Float = { node, _, _ in
    guard let view: UITextView = node?.getContext() else {
        return 0
    }

    return Float((view.font?.ascender ?? 0) + view.contentInset.top + view.textContainerInset.top)
}
