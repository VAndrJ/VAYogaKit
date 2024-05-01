//
//  VAYogaConfig.swift
//
//
//  Created by VAndrJ on 26.04.2024.
//

import UIKit
import yoga

public enum VAYogaConfig {
    @MainActor static let scale = CGFloat(UIScreen.main.scale)

    @MainActor static var globalConfig: YGConfigRef = {
        let globalConfig: YGConfigRef! = YGConfigNew()
        YGConfigSetPointScaleFactor(globalConfig, Float(scale))

        return globalConfig
    }()
}
