//
//  YGNodeTests.swift
//  
//
//  Created by VAndrJ on 26.04.2024.
//

import XCTest
@testable import VAYogaKit
import yoga

final class YGNodeTests: XCTestCase {

    @MainActor
    private func createNode() -> YGNodeRef {
        YGNodeRef.new(for: NSObject())
    }
}
