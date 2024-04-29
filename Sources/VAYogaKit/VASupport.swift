//
//  VASupport.swift
//  
//
//  Created by Volodymyr Andriienko on 25.04.2024.
//

import Foundation

@inline(__always) func assertMain(file: StaticString = #file, line: UInt = #line) {
    #if DEBUG
    assert(Thread.isMainThread, "This method must be called on the main thread.", file: file, line: line)
    #endif
}

@inline(__always) func logLayoutSubviews(file: StaticString = #file, line: UInt = #line) {
    #if DEBUG
    print(file, line)
    #endif
}
