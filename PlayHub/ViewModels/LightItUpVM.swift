//
//  LightItUpVM.swift
//  PlayHub
//
//  Created by Amaya Mahavithane on 2026-07-06.
//

import Foundation
import SwiftUI
import Combine

class LightItUpVM: ObservableObject {

    // MARK: - Game State

    @Published var cards: [LightCard] = []

    @Published var score = 0

    @Published var timeRemaining = 60

    @Published var level: LightLevel = .level1

    @Published var gameOver = false
    
    @Published var showLevelFlash = false

    @AppStorage("lightHighScore")
    var highScore = 0

    // MARK: - Timers

    var gameTimer: Timer?

    var lightTimer: Timer?
    
    // MARK: - Lit Cards

    private var currentLitIndexes: [Int] = []

    init() {
        
        createCards()
    }
        func createCards() {

            cards = []

            for _ in 0..<level.cardCount {

                cards.append(LightCard())

            }

        }
    func resetGame() {

        stopTimers()

        score = 0

        timeRemaining = 60

        level = .level1

        gameOver = false

        currentLitIndexes.removeAll()

        createCards()

    }
    func startGame() {

        resetGame()

        // Light the first card immediately
        lightRandomCards()

        // Countdown timer
        
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in

            self.timeRemaining -= 1

            self.updateLevel()

            if self.timeRemaining <= 0 {

                self.endGame()

            }

        }
        
        // Card lighting timer
        restartLightTimer()

    }
//    func endGame() {
//
//        stopTimers()
//
//        gameOver = true
//
//        if score > highScore {
//
//            highScore = score
//
//        }
//
//    }
    func endGame() {

        stopTimers()

        gameOver = true

        if score > highScore {

            highScore = score

        }

        // Save game session
        let session = GameSession(
            id: UUID(),
            mode: .lightItUp,
            score: score,
            timestamp: Date(),
            latitude: LocationService.shared.latitude,
            longitude: LocationService.shared.longitude
        )

        GameStorage.shared.saveSession(session)

    }
    func updateLevel() {

        let newLevel: LightLevel

        switch timeRemaining {

        case 46...60:
            newLevel = .level1

        case 31...45:
            newLevel = .level2

        case 16...30:
            newLevel = .level3

        default:
            newLevel = .level4
        }

        // Only update if the level actually changed
        if newLevel != level {

            level = newLevel

            showLevelFlash = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {

                self.showLevelFlash = false

            }

            createCards()

            restartLightTimer()

        }
    }
    func restartLightTimer() {

        lightTimer?.invalidate()

        lightTimer = Timer.scheduledTimer(
            withTimeInterval: level.lightDuration,
            repeats: true
        ) { _ in

            self.lightRandomCards()

        }

    }
        func stopTimers() {

            gameTimer?.invalidate()

            lightTimer?.invalidate()

        }
//    func tapCard(at index: Int) {
//
//        guard cards.indices.contains(index) else {
//            return
//        }
//
//        if cards[index].isLit {
//
//            score += 1
//
//            cards[index].isLit = false
//
//        } else {
//
//            score -= 1
//
//        }
//
//    }
    func lightRandomCards() {

        // Apply penalty for cards that were never tapped
//        if !currentLitIndexes.isEmpty {
//
//            score -= currentLitIndexes.count
//
//        }

        // Turn all cards off
        for index in cards.indices {

            cards[index].isLit = false

        }

        currentLitIndexes.removeAll()
        // Choose random cards
        let count = min(level.litCardCount, cards.count)

        while currentLitIndexes.count < count {

            let random = Int.random(in: 0..<cards.count)

            if !currentLitIndexes.contains(random) {

                currentLitIndexes.append(random)

            }
        }

        // Turn selected cards on
        for index in currentLitIndexes {

            cards[index].isLit = true

        }
    }
    func tapCard(at index: Int) {

        guard cards.indices.contains(index) else { return }

        // Correct tap
        if cards[index].isLit {

            score += 1

            cards[index].isLit = false

            currentLitIndexes.removeAll { $0 == index }

        }
        // Wrong tap
        else {

            score -= 1

        }

    }

}
