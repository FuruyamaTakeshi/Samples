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

func printAllWeatherReadings() async {
    do {
        print("Calculation average weahter...")
        
        let result = try await withThrowingTaskGroup(of: [Double].self) { group -> String in
            group.addTask {
                try await getWeatherReadings(for: "London")
            }
            
            group.addTask {
                try await getWeatherReadings(for: "Rome")
            }
            
            group.addTask {
                try await getWeatherReadings(for: "San Francisco")
            }
            
            let allValues = try await group.reduce([], +)
            let average = allValues.reduce(0, +) / Double(allValues.count)
            return "Overall average temperatiure is \(average)"
        }
        print("Done! \(result)")
    } catch {
        print("Error calculating data.")
    }
}

Task {
    await printAllWeatherReadings()
}
