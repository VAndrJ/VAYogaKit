//
//  VAYogaLayout.swift
//
//
//  Created by VAndrJ on 26.04.2024.
//

import Foundation
import yoga

public protocol VAYogaLayout: AnyObject {
    @MainActor var node: YGNodeRef! { get set }
}
