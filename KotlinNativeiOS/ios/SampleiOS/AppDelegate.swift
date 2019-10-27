//
//  AppDelegate.swift
//  SampleiOS
//
//  Created by Furuken on 2019/10/22.
//  Copyright © 2019 古山健司. All rights reserved.
//

import UIKit
import sharedNative

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        CommonKt.helloWorld()
        let user = UserEntity(id: UUID().uuidString, name: "hogetaro")
        print("user.name: \(user.name), \(user.description())")
        print("user.component1(): \(user.component1())")
        print("user.component2(): \(user.component2())")
        print("user: \(user)")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

