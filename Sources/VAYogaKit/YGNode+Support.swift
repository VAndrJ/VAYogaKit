//
//  YGNode+Support.swift
//
//
//  Created by Volodymyr Andriienko on 25.04.2024.
//

import Foundation
import yoga

public extension YGNodeRef {

    func removeAllChildren() {
        YGNodeRemoveAllChildren(self)
    }
}
