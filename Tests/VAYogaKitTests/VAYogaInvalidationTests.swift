import UIKit
import XCTest

@testable import VAYogaKit

final class VAYogaInvalidationTests: XCTestCase {
    @MainActor
    func test_labelInvalidatesParentEvenBeforeMeasureFuncIsInstalled() {
        let root = LayoutInvalidationSpyView()
        let label = VAYogaLabel()
        attach(label, to: root)

        XCTAssertFalse(label.node.hasMeasureFunc)

        label.text = "Updated"

        XCTAssertEqual(1, root.setNeedsLayoutCount)
        XCTAssertFalse(label.node.hasMeasureFunc)
    }

    @MainActor
    func test_labelSizeChangingPropertiesInvalidateMeasuredLayout() {
        let root = LayoutInvalidationSpyView()
        let label = VAYogaLabel()
        attach(label, to: root)

        let mutations: [(VAYogaLabel) -> Void] = [
            { $0.text = "Text" },
            { $0.attributedText = NSAttributedString(string: "Attributed") },
            { $0.font = .boldSystemFont(ofSize: 24) },
            { $0.numberOfLines = 2 },
            { $0.lineBreakMode = .byTruncatingMiddle },
            { $0.adjustsFontSizeToFitWidth = true },
            { $0.minimumScaleFactor = 0.7 },
            { $0.allowsDefaultTighteningForTruncation = true },
            { $0.preferredMaxLayoutWidth = 120 },
        ]

        for mutate in mutations {
            root.calculateLayout(for: .init(width: 200, height: 200))
            root.resetSetNeedsLayoutCount()

            mutate(label)

            XCTAssertEqual(1, root.setNeedsLayoutCount)
        }
    }

    @MainActor
    func test_buttonSizeChangingPropertiesInvalidateMeasuredLayout() {
        let root = LayoutInvalidationSpyView()
        let button = VAYogaButton(frame: .zero)
        attach(button, to: root)

        let mutations: [(VAYogaButton) -> Void] = [
            { $0.setTitle("Title", for: .normal) },
            { $0.setAttributedTitle(NSAttributedString(string: "Attributed"), for: .normal) },
            { $0.setImage(UIImage(), for: .normal) },
            { $0.setBackgroundImage(UIImage(), for: .normal) },
            { $0.setPreferredSymbolConfiguration(.init(pointSize: 20), forImageIn: .normal) },
            { $0.contentEdgeInsets = .init(top: 1, left: 2, bottom: 3, right: 4) },
            { $0.titleEdgeInsets = .init(top: 1, left: 2, bottom: 3, right: 4) },
            { $0.imageEdgeInsets = .init(top: 1, left: 2, bottom: 3, right: 4) },
        ]

        for mutate in mutations {
            root.calculateLayout(for: .init(width: 200, height: 200))
            root.resetSetNeedsLayoutCount()

            mutate(button)

            XCTAssertEqual(1, root.setNeedsLayoutCount)
        }
    }

    @MainActor
    private func attach(_ child: any VAYogaLayout, to root: LayoutInvalidationSpyView) {
        root.sublayouts = [child]
        root.node.removeAllChildren()
        child.node.removeFromParent()
        root.node.insert(child: child.node, at: 0)
        root.resetSetNeedsLayoutCount()
    }
}

@MainActor
private final class LayoutInvalidationSpyView: VAYogaView {
    private(set) var setNeedsLayoutCount = 0

    init() {
        super.init(layoutType: .root)
    }

    override func setNeedsLayout() {
        super.setNeedsLayout()
        setNeedsLayoutCount += 1
    }

    func resetSetNeedsLayoutCount() {
        setNeedsLayoutCount = 0
    }
}
