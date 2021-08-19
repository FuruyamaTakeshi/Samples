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
    let task1 = fibonacci(of: 10)

    let task2 = try await getWeatherReadings(for: "Rome")

    let result1 = task1
    let result2 = task2
    print("The first 50 numbers in the Fibonacci sequence are: \(result1)")
    print("Rome weather readings are: \(result2)")
}

async {
    try await runMultipleCalculations()

}
