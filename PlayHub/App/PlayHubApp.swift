////
////  PlayHubApp.swift
////  PlayHub
////
////  Created by Amaya Mahavithane on 2026-07-06.
////
//

import SwiftUI

@main
struct PlayHubApp: App {

    var body: some Scene {

        WindowGroup {

            let _ = LocationService.shared
            let _ = NotificationService.shared
            
            TabView {

                HomeTab()
                    .tabItem {
                        Label("Home",
                              systemImage: "house.fill")
                    }

                StatsTab()
                    .tabItem {
                        Label("Stats",
                              systemImage: "chart.bar.fill")
                    }

                MapTab()
                    .tabItem {
                        Label("Map",
                              systemImage: "map.fill")
                    }

                SettingsTab()
                    .tabItem {
                        Label("Settings",
                              systemImage: "gearshape.fill")
                    }

            }

        }

    }

}
