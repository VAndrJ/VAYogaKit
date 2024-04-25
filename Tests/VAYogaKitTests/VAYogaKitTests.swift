import XCTest
@testable import VAYogaKit
import yoga

final class VAYogaKitTests: XCTestCase {

    func test_constants_direction() {
        XCTAssertEqual(YGDirectionLTR, .ltr)
        XCTAssertEqual(YGDirectionRTL, .rtl)
        XCTAssertEqual(YGDirectionInherit, .inherit)
    }
}
