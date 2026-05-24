//
//  YG+Support.swift
//
//
//  Created by Volodymyr Andriienko on 25.04.2024.
//

import Foundation
import yoga

extension YGValue {
    public static let zero: YGValue = .point(value: .zero)
    public static let undefined: YGValue = .init(value: .nan, unit: .undefined)
    public static let auto: YGValue = .init(value: .nan, unit: .auto)

    @inline(__always) public static func point(value: Float) -> YGValue {
        YGValue(value: value, unit: .point)
    }

    @inline(__always) public static func point(_ value: CGFloat) -> YGValue {
        YGValue(value: Float(value), unit: .point)
    }

    @inline(__always) public static func percent(value: Float) -> YGValue {
        YGValue(value: value, unit: .percent)
    }

    @inline(__always) public static func percent(_ value: CGFloat) -> YGValue {
        YGValue(value: Float(value), unit: .percent)
    }
}

nonisolated extension YGValue: @retroactive Equatable {
    public static func == (lhs: YGValue, rhs: YGValue) -> Bool {
        lhs.value.isEqual(to: rhs.value) && lhs.unit == rhs.unit
    }
}

public struct VAYogaFlexibility: RawRepresentable, OptionSet {
    public static let flexibleWidth = VAYogaFlexibility(rawValue: 1 << 0)
    public static let flexibleHeight = VAYogaFlexibility(rawValue: 1 << 1)

    public let rawValue: UInt8

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
}

extension Float {
    @inline(__always) public var cg: CGFloat { CGFloat(self) }

    @inline(__always) public func sanitize(measured: CGFloat, mode: YGMeasureMode) -> Float {
        switch mode {
        case .exactly: self
        case .atMost: min(self, Float(measured))
        default: Float(measured)
        }
    }
}
