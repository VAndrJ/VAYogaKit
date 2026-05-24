import UIKit
import XCTest

@testable import VAYogaKit

final class VAYogaFlatteningTests: XCTestCase {
    @MainActor
    func test_flattenLayoutReordersExistingSubviews() {
        let root = ReorderingYogaView()
        root.layoutSubviews()

        XCTAssertSubviewOrder(root.subviews, [root.firstView, root.secondView])

        root.isReversed = true
        root.layoutSubviews()

        XCTAssertSubviewOrder(root.subviews, [root.secondView, root.firstView])
    }

    @MainActor
    func test_scrollFlatteningReordersExistingContentSubviews() {
        let scrollView = VAYogaScrollView(scrollableDirections: .vertical)
        let firstView = VAYogaView()
        let secondView = VAYogaView()
        var isReversed = false
        scrollView.frame = .init(x: 0, y: 0, width: 200, height: 100)
        scrollView.layoutBlock = {
            Row {
                if isReversed {
                    secondView
                    firstView
                } else {
                    firstView
                    secondView
                }
            }
        }

        scrollView.setNeedsUpdateLayout()
        scrollView.layoutSubviews()

        XCTAssertSubviewOrder(scrollView.contentView.subviews, [firstView, secondView])

        isReversed = true
        scrollView.setNeedsUpdateLayout()
        scrollView.layoutSubviews()

        XCTAssertSubviewOrder(scrollView.contentView.subviews, [secondView, firstView])
    }

    @MainActor
    private func XCTAssertSubviewOrder(
        _ actual: [UIView],
        _ expected: [UIView],
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertEqual(actual.count, expected.count, file: file, line: line)

        for (actualSubview, expectedSubview) in zip(actual, expected) {
            XCTAssertTrue(actualSubview === expectedSubview, file: file, line: line)
        }
    }
}

@MainActor
private final class ReorderingYogaView: VAYogaView {
    let firstView = VAYogaView()
    let secondView = VAYogaView()
    var isReversed = false

    override var layout: any VAYogaLayout {
        Row {
            if isReversed {
                secondView
                firstView
            } else {
                firstView
                secondView
            }
        }
    }
}
