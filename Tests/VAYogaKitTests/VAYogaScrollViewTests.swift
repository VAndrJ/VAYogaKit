import UIKit
import XCTest
import yoga

@testable import VAYogaKit

final class VAYogaScrollViewTests: XCTestCase {
    @MainActor
    func test_recomputesLayoutWhenBoundsSizeChangesWhileClean() {
        let (scrollView, probe) = makeScrollView()
        scrollView.layoutSubviews()
        let initialMeasurementCount = probe.measuredSizes.count

        scrollView.bounds = .init(x: 0, y: 0, width: 120, height: 80)
        scrollView.layoutSubviews()

        XCTAssertGreaterThan(probe.measuredSizes.count, initialMeasurementCount)
        XCTAssertEqual(probe.lastMeasuredSize?.width ?? -1, 120, accuracy: 0.5)
        XCTAssertEqual(scrollView.contentSize.width, 120, accuracy: 0.5)
    }

    @MainActor
    func test_doesNotRecomputeLayoutForBoundsOriginChangesWhileClean() {
        let (scrollView, probe) = makeScrollView()
        scrollView.layoutSubviews()
        let initialMeasurementCount = probe.measuredSizes.count

        scrollView.bounds = .init(x: 0, y: 24, width: 200, height: 80)
        scrollView.layoutSubviews()

        XCTAssertEqual(probe.measuredSizes.count, initialMeasurementCount)
    }

    @MainActor
    func test_recomputesLayoutWhenContentInsetChangesWhileClean() {
        let (scrollView, probe) = makeScrollView()
        scrollView.layoutSubviews()
        let initialMeasurementCount = probe.measuredSizes.count

        scrollView.contentInset = .init(top: 0, left: 10, bottom: 0, right: 20)
        scrollView.layoutSubviews()

        XCTAssertGreaterThan(probe.measuredSizes.count, initialMeasurementCount)
        XCTAssertEqual(probe.lastMeasuredSize?.width ?? -1, 170, accuracy: 0.5)
        XCTAssertEqual(scrollView.contentSize.width, 170, accuracy: 0.5)
    }

    @MainActor
    func test_recomputesLayoutWhenSafeAreaInsetsChangeWhileClean() {
        let scrollView = SafeAreaScrollView(scrollableDirections: .vertical)
        let probe = ScrollSizingProbeView()
        var layoutBuildCount = 0
        configure(scrollView)
        scrollView.layoutBlock = {
            layoutBuildCount += 1

            return Column(cross: .stretch) {
                probe
            }
            .padding(.top(scrollView.safeAreaInsets.top))
        }
        scrollView.setNeedsUpdateLayout()
        scrollView.layoutSubviews()
        let initialBuildCount = layoutBuildCount

        scrollView.overriddenSafeAreaInsets = .init(top: 12, left: 0, bottom: 0, right: 0)
        scrollView.triggerSafeAreaInsetsDidChange()
        scrollView.layoutSubviews()

        XCTAssertGreaterThan(layoutBuildCount, initialBuildCount)
        XCTAssertEqual(scrollView.contentSize.height, 32, accuracy: 0.5)
    }

    @MainActor
    private func makeScrollView() -> (VAYogaScrollView, ScrollSizingProbeView) {
        let scrollView = VAYogaScrollView(scrollableDirections: .vertical)
        let probe = ScrollSizingProbeView()
        configure(scrollView)
        scrollView.layoutBlock = {
            Column(cross: .stretch) {
                probe
            }
        }
        scrollView.setNeedsUpdateLayout()

        return (scrollView, probe)
    }

    @MainActor
    private func configure(_ scrollView: VAYogaScrollView) {
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.frame = .init(x: 0, y: 0, width: 200, height: 80)
        scrollView.bounds = .init(x: 0, y: 0, width: 200, height: 80)
    }
}

@MainActor
private final class SafeAreaScrollView: VAYogaScrollView {
    var overriddenSafeAreaInsets: UIEdgeInsets = .zero

    override var safeAreaInsets: UIEdgeInsets {
        overriddenSafeAreaInsets
    }

    func triggerSafeAreaInsetsDidChange() {
        safeAreaInsetsDidChange()
    }
}

@MainActor
private final class ScrollSizingProbeView: UIView, VAYogaLayout {
    let layoutType: VAYogaLayoutType = .selfSizedView
    var node: YGNodeRef!
    var sublayouts: [any VAYogaLayout] = []
    var layout: any VAYogaLayout { self }
    var isDirty = false
    private(set) var measuredSizes: [CGSize] = []
    var lastMeasuredSize: CGSize? { measuredSizes.last }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.node = .new(for: self)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        measuredSizes.append(size)

        return .init(width: size.width, height: 20)
    }

    isolated deinit {
        node.freeSafely()
    }
}
