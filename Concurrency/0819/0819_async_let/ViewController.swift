//
//  ViewController.swift
//  0819_async_let
//
//  Created by Furuken on 2021/08/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            await printUserDetails()
            await printNews()
            do {
                let value = try await fibonacci(of: 10)
                print(value)
            } catch {
                print("catch error")
            }
        }
    }
    
    func getUser() async -> String {
        "Tayler Swift"
    }
    
    func getScores() async -> [Int] {
        [42, 23, 16, 15, 8, 4,]
    }

    func getFriends() async -> [String] {
        ["Eric", "Maeve", "Otis"]
    }
    
    func printUserDetails() async {
        async let username = getUser()
        async let friends = getFriends()
        async let scores = getScores()
        
        let user = await UserData(name: username, scores: scores, friends: friends)
        print("Hello, my name is \(user.name), and I have \(user.friends.count) friends")
    }
    
    func fetchLatestNews(completion: @escaping ([String]) -> Void) {
        DispatchQueue.main.async {
            completion([
                "Swift 5.5 release",
                "Apple acquires Apollo",
                "Swift 6 not release",
            ])
        }
    }
    
    func fetchLatestNews() async -> [String] {
        await withCheckedContinuation({ continuation in
            fetchLatestNews { items in
                continuation.resume(returning: items)
            }
        })
    }
    
    func printNews() async {
        let items = await fetchLatestNews()
        
        for item in items {
            print(item)
        }
    }

}

