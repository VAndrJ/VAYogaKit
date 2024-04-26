import XCTest
@testable import VAYogaKit
import yoga

final class VAYogaKitTests: XCTestCase {

    func test_constants_unit() {
        XCTAssertEqual(YGUnitAuto, .auto)
        XCTAssertEqual(YGUnitPoint, .point)
        XCTAssertEqual(YGUnitUndefined, .undefined)
        XCTAssertEqual(YGUnitPercent, .percent)
    }

    func test_constants_justify() {
        XCTAssertEqual(YGJustifyFlexStart, .start)
        XCTAssertEqual(YGJustifyCenter, .center)
        XCTAssertEqual(YGJustifyFlexEnd, .end)
        XCTAssertEqual(YGJustifySpaceBetween, .spaceBetween)
        XCTAssertEqual(YGJustifySpaceAround, .spaceAround)
        XCTAssertEqual(YGJustifySpaceEvenly, .spaceEvently)
    }

    func test_constants_flexDirection() {
        XCTAssertEqual(YGFlexDirectionRow, .row)
        XCTAssertEqual(YGFlexDirectionRowReverse, .rowReverse)
        XCTAssertEqual(YGFlexDirectionColumn, .column)
        XCTAssertEqual(YGFlexDirectionColumnReverse, .columnReverse)
    }

    func test_constants_direction() {
        XCTAssertEqual(YGDirectionLTR, .ltr)
        XCTAssertEqual(YGDirectionRTL, .rtl)
        XCTAssertEqual(YGDirectionInherit, .inherit)
    }

    func test_constants_edge() {
        XCTAssertEqual(YGEdgeAll, .all)
        XCTAssertEqual(YGEdgeLeft, .left)
        XCTAssertEqual(YGEdgeTop, .top)
        XCTAssertEqual(YGEdgeRight, .right)
        XCTAssertEqual(YGEdgeBottom, .bottom)
        XCTAssertEqual(YGEdgeStart, .start)
        XCTAssertEqual(YGEdgeEnd, .end)
        XCTAssertEqual(YGEdgeHorizontal, .horizontal)
        XCTAssertEqual(YGEdgeVertical, .vertical)
    }
}
