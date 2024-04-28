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

    func test_constants_align() {
        XCTAssertEqual(YGAlignAuto, .auto)
        XCTAssertEqual(YGAlignFlexStart, .start)
        XCTAssertEqual(YGAlignCenter, .center)
        XCTAssertEqual(YGAlignFlexEnd, .end)
        XCTAssertEqual(YGAlignStretch, .stretch)
        XCTAssertEqual(YGAlignBaseline, .baseline)
        XCTAssertEqual(YGAlignSpaceBetween, .spaceBetween)
        XCTAssertEqual(YGAlignSpaceAround, .spaceAround)
        XCTAssertEqual(YGAlignSpaceEvenly, .spaceEvently)
    }

    func test_constants_overflow() {
        XCTAssertEqual(YGOverflowVisible, .visible)
        XCTAssertEqual(YGOverflowHidden, .hidden)
        XCTAssertEqual(YGOverflowScroll, .scroll)
    }

    func test_constants_dismension() {
        XCTAssertEqual(YGDimensionWidth, .width)
        XCTAssertEqual(YGDimensionHeight, .height)
    }

    func test_constants_unit() {
        XCTAssertEqual(YGUnitAuto, .auto)
        XCTAssertEqual(YGUnitPoint, .point)
        XCTAssertEqual(YGUnitUndefined, .undefined)
        XCTAssertEqual(YGUnitPercent, .percent)
    }

    func test_constants_measureMode() {
        XCTAssertEqual(YGMeasureModeUndefined, .undefined)
        XCTAssertEqual(YGMeasureModeExactly, .exactly)
        XCTAssertEqual(YGMeasureModeAtMost, .atMost)
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

    func test_constants_wrap() {
        XCTAssertEqual(YGWrapWrap, .wrap)
        XCTAssertEqual(YGWrapNoWrap, .noWrap)
        XCTAssertEqual(YGWrapWrapReverse, .wrapReverse)
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

    @MainActor
    func test_config_scale() {
        XCTAssertEqual(UIScreen.main.scale, VAYogaConfig.scale)
    }
}
