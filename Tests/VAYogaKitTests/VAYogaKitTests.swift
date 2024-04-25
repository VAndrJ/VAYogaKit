import XCTest
@testable import VAYogaKit
import yoga

final class VAYogaKitTests: XCTestCase {

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
