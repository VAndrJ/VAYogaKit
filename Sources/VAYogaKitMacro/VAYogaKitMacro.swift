//
//  VAYogaKitMacro.swift
//
//
//  Created by VAndrJ on 29.04.2024.
//

@attached(accessor, names: named(didSet))
public macro Layout() = #externalMacro(module: "VAYogaKitMacros", type: "LayoutMacro")
@attached(accessor, names: named(didSet))
public macro DistinctLayout() = #externalMacro(module: "VAYogaKitMacros", type: "DistinctLayoutMacro")
@attached(accessor, names: named(didSet))
public macro ScrollLayout() = #externalMacro(module: "VAYogaKitMacros", type: "ScrollLayoutMacro")
@attached(accessor, names: named(didSet))
public macro DistinctScrollLayout() = #externalMacro(module: "VAYogaKitMacros", type: "ScrollDistinctLayoutMacro")
