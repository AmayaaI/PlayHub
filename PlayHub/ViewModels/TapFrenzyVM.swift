//
//  TapFrenzyVM.swift
//  PlayHub
//
//  Created by Amaya Mahavithane on 2026-07-06.
//

//
//  TapFrenzyVM.swift
//  PlayHub
//

import Foundation
import SwiftUI
import Combine


class TapFrenzyVM: ObservableObject {

    @Published var score = 0
    @Published var highScore = 0
    @Published var timeRemaining = 10
    @Published var gameOver = false

    // Button movement
    @Published var buttonX: CGFloat = 200
    @Published var buttonY: CGFloat = 400

    // Button size
    @Published var buttonSize: CGFloat = 150


    private var timer: Timer?
    private var moveTimer: Timer?


    func startGame() {

        score = 0
        timeRemaining = 10
        gameOver = false
        buttonSize = 150

        resetButtonPosition()

        startTimers()
    }


    func tapButton() {

        guard !gameOver else { return }

        score += 1

    }


    private func startTimers() {

        timer?.invalidate()
        moveTimer?.invalidate()


        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { _ in

            DispatchQueue.main.async {

                if self.timeRemaining > 0 {

                    self.timeRemaining -= 1

                    self.buttonSize = max(
                        60,
                        self.buttonSize - 9
                    )

                } else {

                    self.endGame()

                }

            }

        }


        moveTimer = Timer.scheduledTimer(
            withTimeInterval: 2,
            repeats: true
        ) { _ in

            DispatchQueue.main.async {

                self.resetButtonPosition()

            }

        }

    }


    func endGame() {

        timer?.invalidate()
        moveTimer?.invalidate()

        gameOver = true


        if score > highScore {

            highScore = score

        }


        let session = GameSession(
            id: UUID(),
            mode: .tapFrenzy,
            score: score,
            timestamp: Date(),
            latitude: LocationService.shared.latitude,
            longitude: LocationService.shared.longitude
        )


        GameStorage.shared.saveSession(session)

    }


    func resetButtonPosition() {

        buttonX = CGFloat.random(in: 80...320)

        buttonY = CGFloat.random(in: 250...650)

    }


    deinit {

        timer?.invalidate()
        moveTimer?.invalidate()

    }

}
