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

    @inline(__always) func removeAllChildren() {
        YGNodeRemoveAllChildren(self)
    }
}
