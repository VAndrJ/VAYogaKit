//
//  FrameChangeAnimationView.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 01.05.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit

class FrameChangeAnimationView: BaseView {
    var animationDuration = 0.3
    var isInitialSkipped = false

    override var frame: CGRect {
        get { super.frame }
        set {
            if isInitialSkipped {
                UIView.animate(
                    withDuration: animationDuration,
                    delay: 0,
                    options: [.beginFromCurrentState, .curveLinear]
                ) {
                    super.frame = newValue
                }
            } else {
                if frame.size != newValue.size {
                    super.frame = newValue
                    isInitialSkipped = true
                }
            }
        }
    }
}
