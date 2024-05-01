//
//  Yoga+Titles.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 29.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import Foundation
import yoga

extension YGAlign {
    var title: String {
        switch self {
        case .start: ".start"
        case .end: ".end"
        case .center: ".center"
        case .spaceBetween: ".spaceBetween"
        case .spaceEvently: ".spaceEvently"
        case .spaceAround: ".spaceAround"
        case .stretch: ".stretch"
        case .auto: ".auto"
        case .baseline: ".baseline"
        default: ""
        }
    }
}

extension YGJustify {
    var title: String {
        switch self {
        case .start: ".start"
        case .end: ".end"
        case .center: ".center"
        case .spaceBetween: ".spaceBetween"
        case .spaceEvently: ".spaceEvently"
        case .spaceAround: ".spaceAround"
        default: ""
        }
    }
}
