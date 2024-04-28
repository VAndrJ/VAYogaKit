//
//  YG+Support.swift
//
//
//  Created by Volodymyr Andriienko on 25.04.2024.
//

import Foundation
import yoga

public extension YGValue {
    static let zero: YGValue = .point(value: 0)
    static let undefined: YGValue = .init(value: .nan, unit: .undefined)
    static let auto: YGValue = .init(value: .nan, unit: .auto)

    @inline(__always) static func point(value: Float) -> YGValue {
        YGValue(value: value, unit: .point)
    }

    @inline(__always) static func point(_ value: CGFloat) -> YGValue {
        YGValue(value: Float(value), unit: .point)
    }

    @inline(__always) static func percent(value: Float) -> YGValue {
        YGValue(value: value, unit: .percent)
    }

    @inline(__always) static func percent(_ value: CGFloat) -> YGValue {
        YGValue(value: Float(value), unit: .percent)
    }
}

extension YGValue: Equatable {

    public static func == (lhs: YGValue, rhs: YGValue) -> Bool {
        lhs.value.isEqual(to: rhs.value) && lhs.unit == rhs.unit
    }
}

public extension YGWrap {
    static let wrap: YGWrap = YGWrapWrap
    static let noWrap: YGWrap = YGWrapNoWrap
    static let wrapReverse: YGWrap = YGWrapWrapReverse
}

public extension YGDimension {
    static let width: YGDimension = YGDimensionWidth
    static let height: YGDimension = YGDimensionHeight
}

public extension YGUnit {
    static let point: YGUnit = YGUnitPoint
    static let undefined: YGUnit = YGUnitUndefined
    static let percent: YGUnit = YGUnitPercent
    static let auto: YGUnit = YGUnitAuto
}

public extension YGMeasureMode {
    static let undefined: YGMeasureMode = YGMeasureModeUndefined
    static let exactly: YGMeasureMode = YGMeasureModeExactly
    static let atMost: YGMeasureMode = YGMeasureModeAtMost
}

public extension YGJustify {
    static let start: YGJustify = YGJustifyFlexStart
    static let center: YGJustify = YGJustifyCenter
    static let end: YGJustify = YGJustifyFlexEnd
    static let spaceBetween: YGJustify = YGJustifySpaceBetween
    static let spaceAround: YGJustify = YGJustifySpaceAround
    static let spaceEvently: YGJustify = YGJustifySpaceEvenly
}

public extension YGAlign {
    static let auto: YGAlign = YGAlignAuto
    static let start: YGAlign = YGAlignFlexStart
    static let center: YGAlign = YGAlignCenter
    static let end: YGAlign = YGAlignFlexEnd
    static let stretch: YGAlign = YGAlignStretch
    static let baseline: YGAlign = YGAlignBaseline
    static let spaceBetween: YGAlign = YGAlignSpaceBetween
    static let spaceAround: YGAlign = YGAlignSpaceAround
    static let spaceEvently: YGAlign = YGAlignSpaceEvenly
}

public extension YGFlexDirection {
    static let column: YGFlexDirection = YGFlexDirectionColumn
    static let columnReverse: YGFlexDirection = YGFlexDirectionColumnReverse
    static let row: YGFlexDirection = YGFlexDirectionRow
    static let rowReverse: YGFlexDirection = YGFlexDirectionRowReverse
}

public extension YGEdge {
    static let all: YGEdge = YGEdgeAll
    static let left: YGEdge = YGEdgeLeft
    static let top: YGEdge = YGEdgeTop
    static let right: YGEdge = YGEdgeRight
    static let bottom: YGEdge = YGEdgeBottom
    static let start: YGEdge = YGEdgeStart
    static let end: YGEdge = YGEdgeEnd
    static let horizontal: YGEdge = YGEdgeHorizontal
    static let vertical: YGEdge = YGEdgeVertical
}

public extension YGDirection {
    static let ltr: YGDirection = YGDirectionLTR
    static let rtl: YGDirection = YGDirectionRTL
    static let inherit: YGDirection = YGDirectionInherit
}
