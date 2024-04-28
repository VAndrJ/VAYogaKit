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
    func test_node_baselineFunc_label() {
        let node = createNode(object: UILabel())

        XCTAssertTrue(node.hasBaselineFunc)
    }

    @MainActor
    func test_node_measureFunc() {
        let node = createNode()

        XCTAssertFalse(node.hasMeasureFunc)

        node.setMeasureFunc(measureViewFunc)

        XCTAssertTrue(node.hasMeasureFunc)
    }

    @MainActor
    func test_node_childAddingAndRemoving() {
        let position = 0
        let (parentNode, childNode) = generateSUT()
        checkNodeInserting(parentNode: parentNode, childNode: childNode, position: position)

        parentNode.removeAllChildren()
        checkChildrenAreEmpty(parentNode: parentNode, childNode: childNode, position: position)

        checkNodeInserting(parentNode: parentNode, childNode: childNode, position: position)
        childNode.removeFromParent()
        checkChildrenAreEmpty(parentNode: parentNode, childNode: childNode, position: position)

        checkNodeInserting(parentNode: parentNode, childNode: childNode, position: position)
        parentNode.remove(child: childNode)
        checkChildrenAreEmpty(parentNode: parentNode, childNode: childNode, position: position)
    }

    @MainActor
    private func checkChildrenAreEmpty(
        parentNode: YGNodeRef,
        childNode: YGNodeRef,
        position: Int,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertNil(parentNode.getGhild(at: position))
        XCTAssertEqual(0, parentNode.childCount)
    }

    @MainActor
    private func checkNodeInserting(
        parentNode: YGNodeRef,
        childNode: YGNodeRef,
        position: Int,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        parentNode.insert(child: childNode, at: position)

        XCTAssertEqual(childNode, parentNode.getGhild(at: position), file: file, line: line)
        XCTAssertEqual(parentNode, childNode.parent, file: file, line: line)
        XCTAssertEqual(1, parentNode.childCount, file: file, line: line)
    }

    @MainActor
    private func generateSUT(file: StaticString = #filePath, line: UInt = #line) -> (parent: YGNodeRef, child: YGNodeRef) {
        let parentNode = createNode()

        XCTAssertEqual(0, parentNode.childCount, file: file, line: line)

        let childNode = createNode()

        return (parentNode, childNode)
    }

    @MainActor
    private func createNode(object: NSObject = .init()) -> YGNodeRef {
        YGNodeRef.new(for: object)
    }
}
