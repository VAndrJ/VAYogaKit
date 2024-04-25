//
//  VASupport.swift
//  
//
//  Created by Volodymyr Andriienko on 25.04.2024.
//

import Foundation

@inline(__always) func assertMain() {
    #if DEBUG
    assert(Thread.isMainThread, "This method must be called on the main thread.")
    #endif
}
