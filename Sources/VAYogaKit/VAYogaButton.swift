//
//  VAYogaButton.swift
//  
//
//  Created by VAndrJ on 01.05.2024.
//

import UIKit
import yoga

open class VAYogaButton: UIButton, VAYogaLayout {
    public let layoutType: VAYogaLayoutType = .selfSizedView
    public var node: YGNodeRef!
    public var sublayouts: [any VAYogaLayout] = []
    public var layout: any VAYogaLayout { self }
    public var isDirty = false

    open override var contentEdgeInsets: UIEdgeInsets {
        get { super.contentEdgeInsets }
        set {
            super.contentEdgeInsets = newValue
            invalidateMeasuredSize()
        }
    }

    open override var titleEdgeInsets: UIEdgeInsets {
        get { super.titleEdgeInsets }
        set {
            super.titleEdgeInsets = newValue
            invalidateMeasuredSize()
        }
    }

    open override var imageEdgeInsets: UIEdgeInsets {
        get { super.imageEdgeInsets }
        set {
            super.imageEdgeInsets = newValue
            invalidateMeasuredSize()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.node = .new(for: self)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        invalidateMeasuredSize()
    }

    open override func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) {
        super.setAttributedTitle(title, for: state)
        invalidateMeasuredSize()
    }

    open override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        invalidateMeasuredSize()
    }

    open override func setBackgroundImage(_ image: UIImage?, for state: UIControl.State) {
        super.setBackgroundImage(image, for: state)
        invalidateMeasuredSize()
    }

    open override func setPreferredSymbolConfiguration(
        _ configuration: UIImage.SymbolConfiguration?,
        forImageIn state: UIControl.State
    ) {
        super.setPreferredSymbolConfiguration(configuration, forImageIn: state)
        invalidateMeasuredSize()
    }

    isolated deinit {
        node.freeSafely()
    }

    private func invalidateMeasuredSize() {
        node?.markDirtyIfAvailable()
    }
}
