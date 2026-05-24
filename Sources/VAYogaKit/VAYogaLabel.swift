//
//  VAYogaLabel.swift
//
//
//  Created by VAndrJ on 28.04.2024.
//

import UIKit
import yoga

open class VAYogaLabel: UILabel, VAYogaLayout {
    public let layoutType: VAYogaLayoutType = .selfSizedView
    public var node: YGNodeRef!
    public var sublayouts: [any VAYogaLayout] = []
    public var layout: any VAYogaLayout { self }
    public var isDirty = false

    open override var text: String? {
        get { super.text }
        set {
            super.text = newValue
            invalidateMeasuredSize()
        }
    }

    open override var attributedText: NSAttributedString? {
        get { super.attributedText }
        set {
            super.attributedText = newValue
            invalidateMeasuredSize()
        }
    }

    open override var font: UIFont! {
        get { super.font }
        set {
            super.font = newValue
            invalidateMeasuredSize()
        }
    }

    open override var numberOfLines: Int {
        get { super.numberOfLines }
        set {
            super.numberOfLines = newValue
            invalidateMeasuredSize()
        }
    }

    open override var lineBreakMode: NSLineBreakMode {
        get { super.lineBreakMode }
        set {
            super.lineBreakMode = newValue
            invalidateMeasuredSize()
        }
    }

    open override var adjustsFontSizeToFitWidth: Bool {
        get { super.adjustsFontSizeToFitWidth }
        set {
            super.adjustsFontSizeToFitWidth = newValue
            invalidateMeasuredSize()
        }
    }

    open override var minimumScaleFactor: CGFloat {
        get { super.minimumScaleFactor }
        set {
            super.minimumScaleFactor = newValue
            invalidateMeasuredSize()
        }
    }

    open override var allowsDefaultTighteningForTruncation: Bool {
        get { super.allowsDefaultTighteningForTruncation }
        set {
            super.allowsDefaultTighteningForTruncation = newValue
            invalidateMeasuredSize()
        }
    }

    open override var preferredMaxLayoutWidth: CGFloat {
        get { super.preferredMaxLayoutWidth }
        set {
            super.preferredMaxLayoutWidth = newValue
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

    isolated deinit {
        node.freeSafely()
    }

    private func invalidateMeasuredSize() {
        node?.markDirtyIfAvailable()
    }
}
