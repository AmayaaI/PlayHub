//
//  StatsTab.swift
//  PlayHub
//
//  Created by Amaya Mahavithane on 2026-07-06.
//


import SwiftUI
import Charts

struct StatsTab: View {

    @StateObject private var vm = StatsVM()

    var body: some View {

        NavigationStack {

            List {

//                Section {
//
//                    Button("Add Test Game") {
//
//                        let session = GameSession(
//                            id: UUID(),
//                            mode: .tapFrenzy,
//                            score: Int.random(in: 10...100),
//                            timestamp: Date(),
//                            latitude: 0,
//                            longitude: 0
//                        )
//
//                        GameStorage.shared.saveSession(session)
//
//                        vm.loadSessions()
//
//                    }
//
//                }


                Section("Overall") {

                    HStack {
                        Text("Games Played")

                        Spacer()

                        Text("\(vm.sessions.count)")
                    }


                    HStack {

                        Text("Highest Score")

                        Spacer()

                        Text("\(vm.sessions.map{$0.score}.max() ?? 0)")
                    }


                    HStack {

                        Text("Best Tap Frenzy")

                        Spacer()

                        Text("\(vm.bestTapFrenzy)")
                    }


                    HStack {

                        Text("Best Light It Up")

                        Spacer()

                        Text("\(vm.bestLightItUp)")
                    }


                    HStack {

                        Text("Best Quiz Rush")

                        Spacer()

                        Text("\(vm.bestQuizRush)")
                    }

                }


                Section("Score Chart") {

//                    Chart(vm.sessions) { session in
//
//                        BarMark(
//                            x: .value("Game", session.mode.rawValue),
//                            y: .value("Score", session.score)
//                        )
//
//                    }
                    Chart(vm.sessions) { session in

                        BarMark(
                            x: .value("Played", session.timestamp),
                            y: .value("Score", session.score)
                        )
                        .foregroundStyle(by: .value("Mode", session.mode.rawValue))

                    }
                    .frame(height: 250)

                }


                Section("Recent Games") {

                    if vm.sessions.isEmpty {

                        Text("No games played yet.")

                    } else {

                        ForEach(vm.sessions.reversed()) { session in

                            VStack(alignment: .leading) {

                                Text(session.mode.rawValue)
                                    .font(.headline)

                                Text("Score: \(session.score)")

                                Text(session.timestamp.formatted())
                                    .font(.caption)
                                    .foregroundColor(.gray)

                            }

                        }

                    }

                }

            }
            .navigationTitle("Statistics")

        }

    }
}

#Preview {
    StatsTab()
}
