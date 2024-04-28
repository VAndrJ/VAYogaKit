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
    func test_node_flexShrink() {
        var node = createNode()
        let expected: Float = 0.5

        XCTAssertNotEqual(expected, node.flexShrink)

        node.flexShrink = expected

        XCTAssertEqual(expected, node.flexShrink)
    }

    @MainActor
    func test_node_justifyContent() {
        var node = createNode()
        let expected: YGJustify = .center

        XCTAssertNotEqual(expected, node.justifyContent)

        node.justifyContent = expected

        XCTAssertEqual(expected, node.justifyContent)
    }

    @MainActor
    func test_node_alignContent() {
        var node = createNode()
        let expected: YGAlign = .end

        XCTAssertNotEqual(expected, node.alignContent)

        node.alignContent = expected

        XCTAssertEqual(expected, node.alignContent)
    }

    @MainActor
    func test_node_alignItems() {
        var node = createNode()
        let expected: YGAlign = .end

        XCTAssertNotEqual(expected, node.alignItems)

        node.alignItems = expected

        XCTAssertEqual(expected, node.alignItems)
    }

    @MainActor
    func test_node_alignSelf() {
        var node = createNode()
        let expected: YGAlign = .end

        XCTAssertNotEqual(expected, node.alignSelf)

        node.alignSelf = expected

        XCTAssertEqual(expected, node.alignSelf)
    }

    @MainActor
    func test_node_flexWrap() {
        var node = createNode()
        let expected: YGWrap = .wrapReverse

        XCTAssertNotEqual(expected, node.flexWrap)

        node.flexWrap = expected

        XCTAssertEqual(expected, node.flexWrap)
    }

    @MainActor
    func test_node_overflow() {
        var node = createNode()
        let expected: YGOverflow = .scroll

        XCTAssertNotEqual(expected, node.overflow)

        node.overflow = expected

        XCTAssertEqual(expected, node.overflow)
    }

    @MainActor
    func test_node_display() {
        var node = createNode()
        let expected: YGDisplay = .none

        XCTAssertNotEqual(expected, node.display)

        node.display = expected

        XCTAssertEqual(expected, node.display)
    }

    @MainActor
    func test_node_flex() {
        var node = createNode()
        let expected: Float = 0.5

        XCTAssertNotEqual(expected, node.flex)

        node.flex = expected

        XCTAssertEqual(expected, node.flex)
    }

    @MainActor
    func test_node_flexGrow() {
        var node = createNode()
        let expected: Float = 0.5

        XCTAssertNotEqual(expected, node.flexGrow)

        node.flexGrow = expected

        XCTAssertEqual(expected, node.flexGrow)
    }

    @MainActor
    func test_node_aspectRatio() {
        var node = createNode()
        let expected: Float = 0.5

        XCTAssertNotEqual(expected, node.aspectRatio)

        node.aspectRatio = expected

        XCTAssertEqual(expected, node.aspectRatio)
    }

    @MainActor
    func test_node_flexBasis() {
        var node = createNode()
        let expectedPointValue: YGValue = .point(value: 10)
        node.flexBasis = expectedPointValue

        XCTAssertEqual(expectedPointValue, node.flexBasis)

        let expectedPercentValue: YGValue = .percent(value: 10)
        node.flexBasis = expectedPercentValue

        XCTAssertEqual(expectedPercentValue, node.flexBasis)

        node.flexBasis = .undefined

        XCTAssertTrue(node.flexBasis.value.isNaN)
        XCTAssertTrue(node.flexBasis.unit == .undefined)

        node.flexBasis = .auto

        XCTAssertTrue(node.flexBasis.value.isNaN)
        XCTAssertTrue(node.flexBasis.unit == .auto)
    }

    @MainActor
    func test_node_left() {
        var node = createNode()
        let expectedPointValue: YGValue = .point(value: 10)
        node.left = expectedPointValue

        XCTAssertEqual(expectedPointValue, node.left)

        let expectedPercentValue: YGValue = .percent(value: 10)
        node.left = expectedPercentValue

        XCTAssertEqual(expectedPercentValue, node.left)

        node.left = .undefined

        XCTAssertTrue(node.left.value.isNaN)
        XCTAssertTrue(node.left.unit == .undefined)
    }

    @MainActor
    func test_node_direction() {
        var node = createNode()
        let expected: YGDirection = .rtl

        XCTAssertNotEqual(expected, node.direction)

        node.direction = expected

        XCTAssertEqual(expected, node.direction)
    }

    @MainActor
    func test_node_marginLeft() {
        var node = createNode()
        let expected: YGValue = .point(value: 10)

        XCTAssertNotEqual(expected, node.marginLeft)

        node.marginLeft = expected

        XCTAssertEqual(expected, node.marginLeft)
    }

    @MainActor
    func test_node_marginTop() {
        var node = createNode()
        let expected: YGValue = .point(value: 10)

        XCTAssertNotEqual(expected, node.marginTop)

        node.marginTop = expected

        XCTAssertEqual(expected, node.marginTop)
    }

    @MainActor
    func test_node_marginRight() {
        var node = createNode()
        let expected: YGValue = .point(value: 10)

        XCTAssertNotEqual(expected, node.marginRight)

        node.marginRight = expected

        XCTAssertEqual(expected, node.marginRight)
    }

    @MainActor
    func test_node_marginBottom() {
        var node = createNode()
        let expected: YGValue = .point(value: 10)

        XCTAssertNotEqual(expected, node.marginBottom)

        node.marginBottom = expected

        XCTAssertEqual(expected, node.marginBottom)
    }

    @MainActor
    func test_node_marginStart() {
        var node = createNode()
        let expected: YGValue = .point(value: 10)

        XCTAssertNotEqual(expected, node.marginStart)

        node.marginStart = expected

        XCTAssertEqual(expected, node.marginStart)
    }

    @MainActor
    func test_node_marginEnd() {
        var node = createNode()
        let expected: YGValue = .point(value: 10)

        XCTAssertNotEqual(expected, node.marginEnd)

        node.marginEnd = expected

        XCTAssertEqual(expected, node.marginEnd)
    }

    @MainActor
    func test_node_marginHorizontal() {
        var node = createNode()
        let expected: YGValue = .point(value: 10)

        XCTAssertNotEqual(expected, node.marginHorizontal)

        node.marginHorizontal = expected

        XCTAssertEqual(expected, node.marginHorizontal)
    }

    @MainActor
    func test_node_marginVertical() {
        var node = createNode()
        let expected: YGValue = .point(value: 10)

        XCTAssertNotEqual(expected, node.marginVertical)

        node.marginVertical = expected

        XCTAssertEqual(expected, node.marginVertical)
    }

    @MainActor
    func test_node_margin() {
        var node = createNode()
        let expectedPointValue: YGValue = .point(value: 10)
        node.margin = expectedPointValue

        XCTAssertEqual(expectedPointValue, node.margin)

        let expectedPercentValue: YGValue = .percent(value: 10)
        node.margin = expectedPercentValue

        XCTAssertEqual(expectedPercentValue, node.margin)

        node.margin = .undefined

        XCTAssertTrue(node.margin.value.isNaN)
        XCTAssertTrue(node.margin.unit == .undefined)

        node.margin = .auto

        XCTAssertTrue(node.margin.value.isNaN)
        XCTAssertTrue(node.margin.unit == .auto)
    }

    @MainActor
    func test_node_paddingLeft() {
        var node = createNode()
        let expected: YGValue = .point(value: 10)

        XCTAssertNotEqual(expected, node.paddingLeft)

        node.paddingLeft = expected

        XCTAssertEqual(expected, node.paddingLeft)
    }

    @MainActor
    func test_node_paddingTop() {
        var node = createNode()
        let expected: YGValue = .point(value: 10)

        XCTAssertNotEqual(expected, node.paddingTop)

        node.paddingTop = expected

        XCTAssertEqual(expected, node.paddingTop)
    }

    @MainActor
    func test_node_paddingRight() {
        var node = createNode()
        let expected: YGValue = .point(value: 10)

        XCTAssertNotEqual(expected, node.paddingRight)

        node.paddingRight = expected

        XCTAssertEqual(expected, node.paddingRight)
    }

    @MainActor
    func test_node_paddingBottom() {
        var node = createNode()
        let expected: YGValue = .point(value: 10)

        XCTAssertNotEqual(expected, node.paddingBottom)

        node.paddingBottom = expected

        XCTAssertEqual(expected, node.paddingBottom)
    }

    @MainActor
    func test_node_paddingStart() {
        var node = createNode()
        let expected: YGValue = .point(value: 10)

        XCTAssertNotEqual(expected, node.paddingStart)

        node.paddingStart = expected

        XCTAssertEqual(expected, node.paddingStart)
    }

    @MainActor
    func test_node_paddingEnd() {
        var node = createNode()
        let expected: YGValue = .point(value: 10)

        XCTAssertNotEqual(expected, node.paddingEnd)

        node.paddingEnd = expected

        XCTAssertEqual(expected, node.paddingEnd)
    }

    @MainActor
    func test_node_paddingHorizontal() {
        var node = createNode()
        let expected: YGValue = .point(value: 10)

        XCTAssertNotEqual(expected, node.paddingHorizontal)

        node.paddingHorizontal = expected

        XCTAssertEqual(expected, node.paddingHorizontal)
    }

    @MainActor
    func test_node_paddingVertical() {
        var node = createNode()
        let expected: YGValue = .point(value: 10)

        XCTAssertNotEqual(expected, node.paddingVertical)

        node.paddingVertical = expected

        XCTAssertEqual(expected, node.paddingVertical)
    }

    @MainActor
    func test_node_padding() {
        var node = createNode()
        let expectedPointValue: YGValue = .point(value: 10)
        node.padding = expectedPointValue

        XCTAssertEqual(expectedPointValue, node.padding)

        let expectedPercentValue: YGValue = .percent(value: 10)
        node.padding = expectedPercentValue

        XCTAssertEqual(expectedPercentValue, node.padding)

        node.padding = .undefined

        XCTAssertTrue(node.padding.value.isNaN)
        XCTAssertTrue(node.padding.unit == .undefined)
    }

    @MainActor
    func test_node_flexDirection() {
        var node = createNode()
        let expected: YGFlexDirection = .columnReverse

        XCTAssertNotEqual(expected, node.flexDirection)

        node.flexDirection = expected

        XCTAssertEqual(expected, node.flexDirection)
    }

    @MainActor
    func test_node_maxHeight() {
        var node = createNode()
        let expectedPointValue: YGValue = .point(value: 10)
        node.maxHeight = expectedPointValue

        XCTAssertEqual(expectedPointValue, node.maxHeight)

        let expectedPercentValue: YGValue = .percent(value: 10)
        node.maxHeight = expectedPercentValue

        XCTAssertEqual(expectedPercentValue, node.maxHeight)

        node.maxHeight = .undefined

        XCTAssertTrue(node.maxHeight.value.isNaN)
        XCTAssertTrue(node.maxHeight.unit == .undefined)
    }

    @MainActor
    func test_node_maxWidth() {
        var node = createNode()
        let expectedPointValue: YGValue = .point(value: 10)
        node.maxWidth = expectedPointValue

        XCTAssertEqual(expectedPointValue, node.maxWidth)

        let expectedPercentValue: YGValue = .percent(value: 10)
        node.maxWidth = expectedPercentValue

        XCTAssertEqual(expectedPercentValue, node.maxWidth)

        node.maxWidth = .undefined

        XCTAssertTrue(node.maxWidth.value.isNaN)
        XCTAssertTrue(node.maxWidth.unit == .undefined)
    }

    @MainActor
    func test_node_minHeight() {
        var node = createNode()
        let expectedPointValue: YGValue = .point(value: 10)
        node.minHeight = expectedPointValue

        XCTAssertEqual(expectedPointValue, node.minHeight)

        let expectedPercentValue: YGValue = .percent(value: 10)
        node.minHeight = expectedPercentValue

        XCTAssertEqual(expectedPercentValue, node.minHeight)

        node.minHeight = .undefined

        XCTAssertTrue(node.minHeight.value.isNaN)
        XCTAssertTrue(node.minHeight.unit == .undefined)
    }

    @MainActor
    func test_node_minWidth() {
        var node = createNode()
        let expectedPointValue: YGValue = .point(value: 10)
        node.minWidth = expectedPointValue

        XCTAssertEqual(expectedPointValue, node.minWidth)

        let expectedPercentValue: YGValue = .percent(value: 10)
        node.minWidth = expectedPercentValue

        XCTAssertEqual(expectedPercentValue, node.minWidth)

        node.minWidth = .undefined

        XCTAssertTrue(node.minWidth.value.isNaN)
        XCTAssertTrue(node.minWidth.unit == .undefined)
    }

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
