//
//  GameSession.swift
//  PlayHub
//
//  Created by Amaya Mahavithane on 2026-07-06.
//
import Foundation

struct GameSession: Codable, Identifiable {

    let id: UUID
    let mode: GameMode
    let score: Int
    let timestamp: Date
    let latitude: Double
    let longitude: Double
}
//import Foundation
//
//struct Card: Identifiable {
//    let id = UUID()
//    var isLit: Bool = false
//}
