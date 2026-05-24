import UIKit
import XCTest

@testable import VAYogaKit

final class VAYogaSafeAreaTests: XCTestCase {
    @MainActor
    func test_safeAreaEdgesResetPaddingForExcludedEdges() {
        let root = SafeAreaRootView()
        root.overriddenSafeAreaInsets = .init(top: 10, left: 20, bottom: 30, right: 40)

        root.mode = .edges(.all)
        _ = root.layout

        XCTAssertEqual(root.node.paddingTop, .point(10))
        XCTAssertEqual(root.node.paddingLeft, .point(20))
        XCTAssertEqual(root.node.paddingBottom, .point(30))
        XCTAssertEqual(root.node.paddingRight, .point(40))

        root.mode = .edges([.left, .bottom])
        _ = root.layout

        XCTAssertEqual(root.node.paddingTop, .zero)
        XCTAssertEqual(root.node.paddingLeft, .point(20))
        XCTAssertEqual(root.node.paddingBottom, .point(30))
        XCTAssertEqual(root.node.paddingRight, .zero)
    }

    @MainActor
    func test_safeAreaIgnoredEdgesResetPaddingForIgnoredEdges() {
        let root = SafeAreaRootView()
        root.overriddenSafeAreaInsets = .init(top: 10, left: 20, bottom: 30, right: 40)

        root.mode = .edges(.all)
        _ = root.layout

        root.mode = .ignored([.top, .right])
        _ = root.layout

        XCTAssertEqual(root.node.paddingTop, .zero)
        XCTAssertEqual(root.node.paddingLeft, .point(20))
        XCTAssertEqual(root.node.paddingBottom, .point(30))
        XCTAssertEqual(root.node.paddingRight, .zero)
    }

    @MainActor
    func test_rootViewInvalidatesLayoutWhenSafeAreaInsetsChange() {
        let root = SafeAreaInvalidationSpyView(layoutType: .root)
        root.resetSetNeedsLayoutCount()

        root.triggerSafeAreaInsetsDidChange()

        XCTAssertEqual(root.setNeedsLayoutCount, 1)
    }

    @MainActor
    func test_nonRootViewDoesNotInvalidateLayoutWhenSafeAreaInsetsChange() {
        let view = SafeAreaInvalidationSpyView(layoutType: .view)
        view.resetSetNeedsLayoutCount()

        view.triggerSafeAreaInsetsDidChange()

        XCTAssertEqual(view.setNeedsLayoutCount, 0)
    }
}

@MainActor
private final class SafeAreaRootView: VAYogaView {
    enum Mode {
        case edges(VASafeAreaEdge)
        case ignored(VASafeAreaEdge)
    }

    private let childView = VAYogaView()
    var mode: Mode = .edges(.all)
    var overriddenSafeAreaInsets: UIEdgeInsets = .zero

    override var safeAreaInsets: UIEdgeInsets {
        overriddenSafeAreaInsets
    }

    override var layout: any VAYogaLayout {
        switch mode {
        case let .edges(edges):
            return SafeArea(edges: edges) {
                childView
            }
        case let .ignored(edges):
            return SafeArea(edgesToIgnore: edges) {
                childView
            }
        }
    }

    init() {
        super.init(layoutType: .root)
    }
}

@MainActor
private final class SafeAreaInvalidationSpyView: VAYogaView {
    private(set) var setNeedsLayoutCount = 0

    override func setNeedsLayout() {
        super.setNeedsLayout()
        setNeedsLayoutCount += 1
    }

    func triggerSafeAreaInsetsDidChange() {
        safeAreaInsetsDidChange()
    }

    func resetSetNeedsLayoutCount() {
        setNeedsLayoutCount = 0
    }
}
