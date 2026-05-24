//
//  VAYogaConfig.swift
//
//
//  Created by VAndrJ on 26.04.2024.
//

import UIKit
import yoga

public enum VAYogaConfig {
    static let scale = CGFloat(UIScreen.main.scale)

    static var globalConfig: YGConfigRef = {
        let globalConfig: YGConfigRef! = YGConfigNew()
        YGConfigSetPointScaleFactor(globalConfig, Float(scale))

        return globalConfig
    }()
}
