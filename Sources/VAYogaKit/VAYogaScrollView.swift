//
//  VAYogaScrollView.swift
//
//
//  Created by VAndrJ on 29.04.2024.
//

import UIKit
import yoga

public struct VAYogaScrollableDirection: RawRepresentable, OptionSet, Sendable {
    @MainActor public static let vertical = VAYogaScrollableDirection(rawValue: 1 << 0)
    @MainActor public static let horizontal = VAYogaScrollableDirection(rawValue: 1 << 1)
    @MainActor public static let all: VAYogaScrollableDirection = [.vertical, .horizontal]

    public var rawValue: UInt8

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
}
