import UIKit
import XCTest

@testable import VAYogaKit

final class VAYogaInitializationTests: XCTestCase {
    @MainActor
    func test_viewDoesNotReadLayoutDuringInitialization() {
        let view = LayoutAccessSpyView()

        XCTAssertEqual(view.layoutAccessCount, 0)

        view.layoutSubviews()

        XCTAssertEqual(view.layoutAccessCount, 1)
    }

    @MainActor
    func test_tableViewCellDoesNotReadLayoutDuringInitialization() {
        let cell = LayoutAccessSpyTableViewCell(style: .default, reuseIdentifier: nil)

        XCTAssertEqual(cell.layoutAccessCount, 0)

        _ = cell.sizeThatFits(.init(width: 120, height: CGFloat.greatestFiniteMagnitude))

        XCTAssertEqual(cell.layoutAccessCount, 1)
    }

    @MainActor
    func test_collectionViewCellDoesNotReadLayoutDuringInitialization() {
        let cell = LayoutAccessSpyCollectionViewCell(frame: .init(x: 0, y: 0, width: 120, height: 80))

        XCTAssertEqual(cell.layoutAccessCount, 0)

        _ = cell.sizeThatFits(.init(width: 120, height: 80))

        XCTAssertEqual(cell.layoutAccessCount, 1)
    }

    @MainActor
    func test_scrollViewDoesNotReadLayoutDuringInitialization() {
        let scrollView = LayoutAccessSpyScrollView(scrollableDirections: .vertical)
        scrollView.frame = .init(x: 0, y: 0, width: 120, height: 80)
        scrollView.bounds = .init(x: 0, y: 0, width: 120, height: 80)

        XCTAssertEqual(scrollView.layoutAccessCount, 0)

        scrollView.layoutSubviews()

        XCTAssertEqual(scrollView.layoutAccessCount, 1)
    }
}

@MainActor
private final class LayoutAccessSpyView: VAYogaView {
    private let childView = VAYogaView()
    private(set) var layoutAccessCount = 0

    override var layout: any VAYogaLayout {
        layoutAccessCount += 1

        return childView
    }
}

@MainActor
private final class LayoutAccessSpyTableViewCell: VAYogaTableViewCell {
    private let childView = VAYogaView()
    private(set) var layoutAccessCount = 0

    override var layout: any VAYogaLayout {
        layoutAccessCount += 1

        return childView
    }
}

@MainActor
private final class LayoutAccessSpyCollectionViewCell: VAYogaCollectionViewCell {
    private let childView = VAYogaView()
    private(set) var layoutAccessCount = 0

    override var layout: any VAYogaLayout {
        layoutAccessCount += 1

        return childView
    }
}

@MainActor
private final class LayoutAccessSpyScrollView: VAYogaScrollView {
    private let childView = VAYogaView()
    private(set) var layoutAccessCount = 0

    override var layout: any VAYogaLayout {
        layoutAccessCount += 1

        return childView
    }
}
