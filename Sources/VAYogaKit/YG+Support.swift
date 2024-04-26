//
//  YG+Support.swift
//
//
//  Created by Volodymyr Andriienko on 25.04.2024.
//

import Foundation
import yoga

extension YGUnit {
    static let point: YGUnit = YGUnitPoint
    static let undefined: YGUnit = YGUnitUndefined
    static let percent: YGUnit = YGUnitPercent
    static let auto: YGUnit = YGUnitAuto
}

extension YGJustify {
    static let start: YGJustify = YGJustifyFlexStart
    static let center: YGJustify = YGJustifyCenter
    static let end: YGJustify = YGJustifyFlexEnd
    static let spaceBetween: YGJustify = YGJustifySpaceBetween
    static let spaceAround: YGJustify = YGJustifySpaceAround
    static let spaceEvently: YGJustify = YGJustifySpaceEvenly
}

extension YGFlexDirection {
    static let column: YGFlexDirection = YGFlexDirectionColumn
    static let columnReverse: YGFlexDirection = YGFlexDirectionColumnReverse
    static let row: YGFlexDirection = YGFlexDirectionRow
    static let rowReverse: YGFlexDirection = YGFlexDirectionRowReverse
}

extension YGEdge {
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

extension YGDirection {
    static let ltr: YGDirection = YGDirectionLTR
    static let rtl: YGDirection = YGDirectionRTL
    static let inherit: YGDirection = YGDirectionInherit
}
