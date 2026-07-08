//
//  GameStorage.swift
//  PlayHub
//
//  Created by Amaya Mahavithane on 2026-07-08.
//

import Foundation

class GameStorage {

    static let shared = GameStorage()

    private let key = "GameSessions"

    func loadSessions() -> [GameSession] {

        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }

        do {
            return try JSONDecoder().decode([GameSession].self, from: data)
        } catch {
            print(error)
            return []
        }
    }

    func saveSession(_ session: GameSession) {

        var sessions = loadSessions()

        sessions.append(session)

        do {

            let data = try JSONEncoder().encode(sessions)

            UserDefaults.standard.set(data, forKey: key)

        } catch {

            print(error)

        }

    }

//    func clearSessions() {
//
//        UserDefaults.standard.removeObject(forKey: key)
//
//    }
    func reset() {
        UserDefaults.standard.removeObject(forKey: key)
    }

}
