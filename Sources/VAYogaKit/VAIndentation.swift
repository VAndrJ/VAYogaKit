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
