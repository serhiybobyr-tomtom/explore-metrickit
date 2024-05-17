//
//  ExploreMetricKitApp.swift
//  ExploreMetricKit
//
//  Created by Serhiy Bobyr on 17/05/2024.
//

import SwiftUI

@main
struct ExploreMetricKitApp: App {
    let metricReporter = MetricReporter()

    init() {
        metricReporter.setup()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
