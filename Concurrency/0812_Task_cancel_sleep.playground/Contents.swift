import UIKit

var greeting = "Hello, playground"

func cancelSleepingTask() async throws {
    let task = Task { () -> String in
        print("Starting: ")
        print("\(Date())")
        await Task.sleep(1_500_000_000)
        try Task.checkCancellation()
        return "Done"
    }
    
    task.cancel()
    do {
        let result = try await task.value
        print("Result: \(result)")
    } catch {
        print("task.result: \(await task.result)")
        print("Task was canceled.")
        print("\(Date())")

    }
}

Task.init {
    try await cancelSleepingTask()
}

func printMessage() async {
    let string = await withTaskGroup(of: String.self) { group -> String in
        group.addTask { "Hello" }
        group.addTask { "From" }
        group.addTask { "A" }
        group.addTask { "Task" }
        group.addTask { "Group" }
        
        var collected = [String]()
        
        for await value in group {
            collected.append(value)
        }
        
        return collected.joined(separator: " ")
    }
    print(string)
}

Task.init {
    await printMessage()
}
