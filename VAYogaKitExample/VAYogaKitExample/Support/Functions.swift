//
//  Functions.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 28.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import Foundation

public func mainAsync(
    after: TimeInterval = 0,
    @_implicitSelfCapture _ block: @Sendable @escaping () -> Void
) {
    if after > 0 {
        DispatchQueue.main.asyncAfter(deadline: .now() + after, execute: block)
    } else {
        DispatchQueue.main.async(execute: block)
    }
}
