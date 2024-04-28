//
//  VASafeAreaEdge.swift
//  
//
//  Created by VAndrJ on 28.04.2024.
//

import Foundation

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
