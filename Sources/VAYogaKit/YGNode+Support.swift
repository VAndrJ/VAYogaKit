//
//  YGNode+Support.swift
//
//
//  Created by Volodymyr Andriienko on 25.04.2024.
//

import Foundation
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

    @inline(__always) func remove(child: YGNodeRef?) {
        YGNodeRemoveChild(self, child)
    }

    @inline(__always) func removeAllChildren() {
        YGNodeRemoveAllChildren(self)
    }

    func getGhild(at index: Int) -> YGNodeRef? {
        YGNodeGetChild(self, index)
    }
}
