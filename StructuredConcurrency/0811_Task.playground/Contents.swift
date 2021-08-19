import UIKit
import Foundation

enum LocationError: Error {
    case unknown
}

func getWeatherReadings(for location: String) async throws -> [Double] {
    switch location {
    case "London":
        return (1...100).map { _ in Double.random(in: 6...26) }
    case "Rome":
        return (1...100).map { _ in Double.random(in: 10...32) }
    case "San Francisco":
        return (1...100).map { _ in Double.random(in: 12...20) }
    default:
        throw LocationError.unknown
    }
}

func fibonacci(of number: Int) -> Int {
    var first = 0
    var second = 1

    for _ in 0..<number {
        let previous = first
        first = second
        second = previous + first
    }

    return first
}

func printFibonacciSequence() async {
    let task1 = Task { () -> [Int] in
        var numbers = [Int]()
        
        for i in 0..<50 {
            let result = fibonacci(of: i)
            numbers.append(result)
        }
        return numbers
    }
    let result1 = await task1.value
    print("The first 50 numbers in the Fibonacci sequence are: \(result1)")
}

func printFibonacciSequence1() async {
    print("Is main thread: \(Thread.isMainThread)")
    let task1 = Task {
        (0..<50).map(fibonacci)
    }
    let result1 = await task1.value
    print("#The first 50 numbers in the Fibonacci sequence are: \(result1)")
}

print("Step0")

Task.init(priority: .background) {
    print("Step1")
    await printFibonacciSequence()
    print("Step2")
    await printFibonacciSequence1()
    print("Step3")
}

print("Step4")
