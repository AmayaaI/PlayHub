//
//  MapTab.swift
//  PlayHub
//
//  Created by Amaya Mahavithane on 2026-07-06.
//

import SwiftUI
import MapKit

struct MapTab: View {

    @StateObject var vm = StatsVM()

    var body: some View {

        NavigationStack {

            Map {

                ForEach(vm.sessions) { session in

                    Marker(
                        "\(session.score)",
                        coordinate: CLLocationCoordinate2D(
                            latitude: session.latitude,
                            longitude: session.longitude
                        )
                    )

                }

            }

            .navigationTitle("Game Map")

        }

    }

}

#Preview {

    MapTab()

}
