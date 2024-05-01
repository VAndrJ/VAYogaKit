//
//  BaseButton.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 01.05.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit
import VAYogaKit

class BaseButton: VAYogaButton {
    var onTap: (() -> Void)?

    convenience init(onTap: (() -> Void)? = nil) {
        self.init(type: .system)

        self.onTap = onTap
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        bind()
    }

    private func bind() {
        addTarget(
            self,
            action: #selector(onTouchUpInside),
            for: .touchUpInside
        )
    }

    @objc private func onTouchUpInside() {
        onTap?()
    }
}
