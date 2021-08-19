//
//  Fibonacci.swift
//  Fibonacci
//
//  Created by Furuken on 2021/08/13.
//

import Foundation

enum NumberError: Error {
    case outOfRange
}

func fibonacci(of number: Int) async throws -> Int {
    guard number >= 0 && number <=  22 else {
        throw NumberError.outOfRange
    }
    
    guard number >= 2 else {
        return number
    }
    
    async let first = fibonacci(of: number - 2)
    async let second = fibonacci(of: number - 1)
    return try await first + second
}
