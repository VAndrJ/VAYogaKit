//
//  VASafeAreaEdge.swift
//  
//
//  Created by VAndrJ on 28.04.2024.
//

import UIKit

/// A set of options representing safe area edges.
public struct VASafeAreaEdge: RawRepresentable, OptionSet, Sendable {
    public var rawValue: UInt

    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }

    public static let top = VASafeAreaEdge(rawValue: 1 << 1)
    public static let left = VASafeAreaEdge(rawValue: 1 << 2)
    public static let bottom = VASafeAreaEdge(rawValue: 1 << 3)
    public static let right = VASafeAreaEdge(rawValue: 1 << 4)
    public static let vertical: VASafeAreaEdge = [top, bottom]
    public static let horizontal: VASafeAreaEdge = [left, right]
    public static let all: VASafeAreaEdge = [top, left, bottom, right]
}

/// Maps the specified safe area edges to an array of `VAIndentation` representing the insets.
///
/// - Parameters:
///   - edges: The safe area edges to be mapped to `VAIndentation`.
///   - view: The `UIView` representing the container node that provides safe area insets.
/// - Returns: An array of `VAIndentation` representing the insets for each edge based on the specified safe area edges.
@MainActor
public func mapToIndentation(edges: VASafeAreaEdge, in view: UIView) -> [VAIndentation] {
    var paddings: [VAIndentation] = []
    if edges.contains(.top) {
        paddings.append(.top(view.safeAreaInsets.top))
    }
    if edges.contains(.left) {
        paddings.append(.left(view.safeAreaInsets.left))
    }
    if edges.contains(.bottom) {
        paddings.append(.bottom(view.safeAreaInsets.bottom))
    }
    if edges.contains(.right) {
        paddings.append(.right(view.safeAreaInsets.right))
    }

    return paddings
}
