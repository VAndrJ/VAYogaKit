import UIKit
import XCTest

@testable import VAYogaKit
import yoga

final class VAYogaCellSizingTests: XCTestCase {
    @MainActor
    func test_tableViewCellSizeThatFitsUsesProposedWidth() {
        let cell = TableCellSizingFixture()
        cell.frame = .init(x: 0, y: 0, width: 320, height: 44)
        cell.contentView.frame = .init(x: 0, y: 0, width: 320, height: 44)

        let fittedSize = cell.sizeThatFits(
            .init(width: 120, height: CGFloat.greatestFiniteMagnitude)
        )

        XCTAssertEqual(cell.probe.lastMeasuredSize?.width ?? -1, 120, accuracy: 0.5)
        XCTAssertEqual(fittedSize.width, 120, accuracy: 0.5)
        XCTAssertEqual(fittedSize.height, 30, accuracy: 0.5)
    }

    @MainActor
    func test_collectionViewCellSizeThatFitsUsesProposedSize() {
        let cell = CollectionCellSizingFixture(frame: .init(x: 0, y: 0, width: 320, height: 320))
        cell.contentView.frame = .init(x: 0, y: 0, width: 320, height: 320)

        let fittedSize = cell.sizeThatFits(.init(width: 120, height: 80))

        XCTAssertEqual(cell.probe.lastMeasuredSize?.width ?? -1, 120, accuracy: 0.5)
        XCTAssertEqual(fittedSize.width, 120, accuracy: 0.5)
        XCTAssertEqual(fittedSize.height, 80, accuracy: 0.5)
    }

    @MainActor
    func test_collectionViewCellLayoutSubviewsClearsDirtyFlag() {
        let cell = CollectionCellSizingFixture(frame: .init(x: 0, y: 0, width: 160, height: 100))
        cell.contentView.frame = .init(x: 0, y: 0, width: 160, height: 100)
        cell.isDirty = true

        cell.layoutSubviews()

        XCTAssertFalse(cell.isDirty)

        let measurementCount = cell.probe.measuredSizes.count
        cell.layoutSubviews()

        XCTAssertEqual(cell.probe.measuredSizes.count, measurementCount)
    }
}

@MainActor
private final class TableCellSizingFixture: VAYogaTableViewCell {
    let probe = CellSizingProbeView()

    init() {
        super.init(style: .default, reuseIdentifier: nil)
    }

    override var layout: any VAYogaLayout {
        Column(cross: .stretch) {
            probe
        }
    }
}

@MainActor
private final class CollectionCellSizingFixture: VAYogaCollectionViewCell {
    let probe = CellSizingProbeView()

    override var layout: any VAYogaLayout {
        Column(cross: .stretch) {
            probe
        }
    }
}

@MainActor
private final class CellSizingProbeView: UIView, VAYogaLayout {
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

        return .init(width: size.width, height: size.width / 4)
    }

    isolated deinit {
        node.freeSafely()
    }
}
