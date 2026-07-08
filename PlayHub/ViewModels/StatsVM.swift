//
//  StatsVM.swift
//  PlayHub
//
//  Created by Amaya Mahavithane on 2026-07-06.
//

import Foundation
import Combine

class StatsVM: ObservableObject {

    @Published var sessions: [GameSession] = []

    init() {
        loadSessions()
    }

    func loadSessions() {

        sessions = GameStorage.shared.loadSessions()

    }
    var bestTapFrenzy: Int {
        sessions
            .filter { $0.mode == .tapFrenzy }
            .map { $0.score }
            .max() ?? 0
    }

    var bestLightItUp: Int {
        sessions
            .filter { $0.mode == .lightItUp }
            .map { $0.score }
            .max() ?? 0
    }

    var bestQuizRush: Int {
        sessions
            .filter { $0.mode == .quizRush }
            .map { $0.score }
            .max() ?? 0
    }

}
