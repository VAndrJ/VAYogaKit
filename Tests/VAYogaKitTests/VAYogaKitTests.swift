import XCTest
@testable import VAYogaKit
import yoga

final class VAYogaKitTests: XCTestCase {
    func test_ygValue_point() {
        let value: Float = 10
        let expected: YGValue = .init(value: value, unit: .point)
        let sut: YGValue = .point(value: value)

        XCTAssertEqual(expected, sut)
    }

    func test_ygValue_percent() {
        let value: Float = 10
        let expected: YGValue = .init(value: value, unit: .percent)
        let sut: YGValue = .percent(value: value)

        XCTAssertEqual(expected, sut)
    }

    func test_ygValue_point_cgfloat() {
        let value: CGFloat = 10
        let expected: YGValue = .init(value: Float(value), unit: .point)
        let sut: YGValue = .point(value)

        XCTAssertEqual(expected, sut)
    }

    func test_ygValue_percent_cgfloat() {
        let value: CGFloat = 10
        let expected: YGValue = .init(value: Float(value), unit: .percent)
        let sut: YGValue = .percent(value)

        XCTAssertEqual(expected, sut)
    }

    func test_constants_ygValue() {
        XCTAssertEqual(YGValue(value: 0, unit: .point), .zero)
        XCTAssertTrue(YGValue.undefined.value.isNaN)
        XCTAssertEqual(.undefined, YGValue.undefined.unit)
        XCTAssertTrue(YGValue.auto.value.isNaN)
        XCTAssertEqual(.auto, YGValue.auto.unit)
    }

    @MainActor
    func test_config_scale() {
        XCTAssertEqual(UIScreen.main.scale, VAYogaConfig.scale)
    }
}
