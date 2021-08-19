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

func runMultipleCalculations() async throws {
    print("#0")
    let task1 = Task {
        (0..<50).map(fibonacci)
    }
    print("#1")
    let task2 = Task {
        try await getWeatherReadings(for: "Rome")
    }
    print("#2")
    let result1 = await task1.value
    print("#3")
    let result2 = try await task2.value
    print("#4")
    print("The first 50 members in the Fibonacci sequence are: \(result1)")
    print("#5")
    print("Rome weather readings are: \(result2)")
    print("#6")
}

print("Step1")
Task.init(priority: .background) {
    print("Step2")
    try await runMultipleCalculations()
    print("Step3")
}
print("Step4")
