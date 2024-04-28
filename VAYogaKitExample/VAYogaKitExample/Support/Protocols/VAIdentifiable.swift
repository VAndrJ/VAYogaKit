//
//  VAIdentifiable.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 28.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import Foundation

protocol VAIdentifiable {
    static var identifier: String { get }
    var identifier: String { get }
}

extension VAIdentifiable {
    static var identifier: String { String(describing: Self.self) }

    var identifier: String { Self.identifier }
}
