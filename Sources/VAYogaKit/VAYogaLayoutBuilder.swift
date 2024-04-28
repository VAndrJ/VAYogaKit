//
//  VAYogaLayoutBuilder.swift
//  
//
//  Created by VAndrJ on 28.04.2024.
//

import Foundation

@resultBuilder
public struct VAYogaLayoutBuilder {

    public static func buildBlock(_ components: [VAYogaLayout]) -> [VAYogaLayout] {
        components
    }

    public static func buildBlock(_ components: [VAYogaLayout]...) -> [VAYogaLayout] {
        components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: VAYogaLayout) -> [VAYogaLayout] {
        [expression]
    }

    public static func buildExpression(_ expression: [VAYogaLayout]) -> [VAYogaLayout] {
        expression
    }

    public static func buildOptional(_ component: [VAYogaLayout]?) -> [VAYogaLayout] {
        component ?? []
    }

    public static func buildEither(first component: [VAYogaLayout]) -> [VAYogaLayout] {
        component
    }

    public static func buildEither(second component: [VAYogaLayout]) -> [VAYogaLayout] {
        component
    }
}
