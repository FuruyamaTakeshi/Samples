//: Playground - noun: a place where people can play

import Foundation

struct GoogleAnalytcis {
    static let shared = GoogleAnalytcis()
    func trackerWithTrackingId(_ key: String) {}
}

struct Analytics {
    static func createTracker(key: String) {
        GoogleAnalytcis.shared.trackerWithTrackingId(key)
    }
}

Analytics.createTracker(key: "myTracker")