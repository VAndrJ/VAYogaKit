import UIKit
import XCTest

@testable import VAYogaKit
import yoga

final class VAYogaComponentTests: XCTestCase {
    @MainActor
    func test_columnMapsSpacingToRowGapAndColumnToColumnGap() {
        let column = Column(spacing: 8, column: 13) {}

        XCTAssertEqual(column.node.rowGap, 8)
        XCTAssertEqual(column.node.columnGap, 13)
    }

    @MainActor
    func test_rowMapsSpacingToColumnGapAndRowToRowGap() {
        let row = Row(spacing: 8, row: 13) {}

        XCTAssertEqual(row.node.columnGap, 8)
        XCTAssertEqual(row.node.rowGap, 13)
    }

    @MainActor
    func test_wrappingColumnUsesColumnGapBetweenWrappedColumns() {
        let views = fixedSizeViews(count: 4, size: .init(width: 20, height: 20))
        let column = Column(spacing: 10, wrap: .wrap, column: 30) {
            views[0]
            views[1]
            views[2]
            views[3]
        }

        column.calculateLayout(for: .init(width: 200, height: 50))
        column.applyLayoutToHierarchy(keepingOrigin: false)

        XCTAssertEqual(views[0].frame.origin, .init(x: 0, y: 0))
        XCTAssertEqual(views[1].frame.origin, .init(x: 0, y: 30))
        XCTAssertEqual(views[2].frame.origin, .init(x: 50, y: 0))
        XCTAssertEqual(views[3].frame.origin, .init(x: 50, y: 30))
    }

    @MainActor
    func test_wrappingRowUsesRowGapBetweenWrappedRows() {
        let views = fixedSizeViews(count: 4, size: .init(width: 20, height: 20))
        let row = Row(spacing: 10, wrap: .wrap, row: 30) {
            views[0]
            views[1]
            views[2]
            views[3]
        }

        row.calculateLayout(for: .init(width: 50, height: 200))
        row.applyLayoutToHierarchy(keepingOrigin: false)

        XCTAssertEqual(views[0].frame.origin, .init(x: 0, y: 0))
        XCTAssertEqual(views[1].frame.origin, .init(x: 30, y: 0))
        XCTAssertEqual(views[2].frame.origin, .init(x: 0, y: 50))
        XCTAssertEqual(views[3].frame.origin, .init(x: 30, y: 50))
    }

    @MainActor
    private func fixedSizeViews(count: Int, size: CGSize) -> [VAYogaView] {
        (0..<count).map { _ in
            VAYogaView().sized(size)
        }
    }
}
