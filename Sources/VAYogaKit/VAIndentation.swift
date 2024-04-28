//
//  VAIndentation.swift
//
//
//  Created by VAndrJ on 28.04.2024.
//

import UIKit

/// An enumeration that represents various padding configurations for layout elements.
public enum VAIndentation {
    /// Indentation only at the top of the layout element.
    case top(CGFloat)
    /// Indentation only at the left of the layout element.
    case left(CGFloat)
    /// Indentation only at the bottom of the layout element.
    case bottom(CGFloat)
    /// Indentation only at the right of the layout element.
    case right(CGFloat)
    /// Horizontal indentation, applied to both left and right of the layout element.
    case horizontal(CGFloat)
    /// Vertical indentation, applied to both top and bottom of the layout element.
    case vertical(CGFloat)
    /// Uniform indentation applied to all edges of the layout element: top, left, bottom, right
    case all(CGFloat)
    /// Indentation at the top-left corner, applied to both top and left of the layout element.
    case topLeft(CGFloat)
    /// Indentation at the top-right corner, applied to both top and right of the layout element.
    case topRight(CGFloat)
    /// Indentation at the bottom-left corner, applied to both bottom and left of the layout element.
    case bottomLeft(CGFloat)
    /// Indentation at the bottom-right corner, applied to both bottom and right of the layout element.
    case bottomRight(CGFloat)
    /// Custom indentation with individual values for top, left, bottom, and right edges.
    case custom(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
    /// Indentation defined using UIEdgeInsets.
    case insets(UIEdgeInsets)
}

public extension VAIndentation {
    
    /// Maps the specified safe area edges to an array of `VAIndentation` representing the insets.
    ///
    /// - Parameters:
    ///   - edges: The safe area edges to be mapped to `VAIndentation`.
    ///   - view: The `UIView` representing the container node that provides safe area insets.
    /// - Returns: An array of `VAIndentation` representing the insets for each edge based on the specified safe area edges.
    @MainActor
    static func map(edges: VASafeAreaEdge, in view: UIView) -> [VAIndentation] {
        var paddings: [VAIndentation] = []
        if edges.contains(.top) {
            paddings.append(.top(view.safeAreaInsets.top))
        }
        if edges.contains(.left) {
            paddings.append(.left(view.safeAreaInsets.left))
        }
        if edges.contains(.bottom) {
            paddings.append(.bottom(view.safeAreaInsets.bottom))
        }
        if edges.contains(.right) {
            paddings.append(.right(view.safeAreaInsets.right))
        }

        return paddings
    }
}

public extension UIEdgeInsets {

    /// Creates a `UIEdgeInsets` instance based on an array of indentation configurations.
    ///
    /// - Parameter indentation: An array of `VAIndentation` representing the padding values for each edge of the insets.
    init(indentation: [VAIndentation]) {
        var top: CGFloat = 0
        var left: CGFloat = 0
        var bottom: CGFloat = 0
        var right: CGFloat = 0
        indentation.forEach {
            switch $0 {
            case let .insets(insets):
                top = insets.top
                left = insets.left
                bottom = insets.bottom
                right = insets.right
            case let .custom(paddingTop, paddingLeft, paddingBottom, paddingRight):
                top = paddingTop
                left = paddingLeft
                bottom = paddingBottom
                right = paddingRight
            case let .vertical(padding):
                top = padding
                bottom = padding
            case let .horizontal(padding):
                left = padding
                right = padding
            case let .all(padding):
                top = padding
                left = padding
                bottom = padding
                right = padding
            case let .bottom(padding):
                bottom = padding
            case let .top(padding):
                top = padding
            case let .left(padding):
                left = padding
            case let .right(padding):
                right = padding
            case let .topLeft(padding):
                top = padding
                left = padding
            case let .topRight(padding):
                top = padding
                right = padding
            case let .bottomLeft(padding):
                left = padding
                bottom = padding
            case let .bottomRight(padding):
                bottom = padding
                right = padding
            }
        }

        self.init(top: top, left: left, bottom: bottom, right: right)
    }
}
