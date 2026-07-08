//
//  TapFrenzyView.swift
//  PlayHub
//
//  Created by Amaya Mahavithane on 2026-07-06.
//

import SwiftUI
import Combine

struct TapFrenzyView: View {

    @State private var score = 0
    @State private var highScore = 0
    @State private var timeRemaining = 10
    @State private var gameOver = false

    // Moving target
    @State private var buttonX: CGFloat = 200
    @State private var buttonY: CGFloat = 400

    // Shrinking button
    @State private var buttonSize: CGFloat = 150
    @StateObject private var vm = TapFrenzyVM()

    let timer = Timer.publish(every: 1,
                              on: .main,
                              in: .common).autoconnect()

    let moveTimer = Timer.publish(every: 2,
                                  on: .main,
                                  in: .common).autoconnect()

    var body: some View {

        ZStack {

            Color.blue.opacity(0.1)
                .ignoresSafeArea()

            if !gameOver {

                VStack {

                    Text("Tap Frenzy")
                        .font(.largeTitle)
                        .bold()

                    Text("Score: \(score)")
                        .font(.title)

                    Text("Time: \(timeRemaining)")
                        .font(.title2)

                    Spacer()
                }

                Button {

                    guard !gameOver else { return }

                    score += 1

                } label: {

                    Text("TAP")
                        .font(.largeTitle)
                        .bold()
                        .frame(width: buttonSize, height: buttonSize)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .position(x: buttonX, y: buttonY)

            } else {

                VStack(spacing: 20) {

                    Text("Game Over")
                        .font(.largeTitle)
                        .bold()

                    Text("Final Score: \(score)")
                        .font(.title)

                    if score == highScore && score > 0 {
                        Text("🎉 New High Score!")
                            .font(.title2)
                            .foregroundColor(.green)
                    }

                    Text("High Score: \(highScore)")
                        .font(.title2)

                    Button("Play Again") {
                        restartGame()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }

        .onAppear {
            resetButtonPosition()
        }

        .onReceive(timer) { _ in

            guard !gameOver else { return }

            if timeRemaining > 0 {

                timeRemaining -= 1

                // Shrinking challenge
                buttonSize = max(60, buttonSize - 9)

            }
//            else {
//                
//                gameOver = true
//
//                if score > highScore {
//                    highScore = score
//                }
//
//                let session = GameSession(
//                    id: UUID(),
//                    mode: .tapFrenzy,
//                    score: score,
//                    timestamp: Date(),
//                    latitude: LocationService.shared.latitude,
//                    longitude: LocationService.shared.longitude
//                )
//
//                GameStorage.shared.saveSession(session)
//            }
            else {

                if !gameOver {

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
            }
//            else {
//
//                gameOver = true
//
//                if score > highScore {
//                    highScore = score
//                }
//            }
        }

        .onReceive(moveTimer) { _ in

            guard !gameOver else { return }

            withAnimation {
                resetButtonPosition()
            }
        }
    }

    // MARK: - Restart Game
    func restartGame() {
        score = 0
        timeRemaining = 10
        gameOver = false
        buttonSize = 150

        resetButtonPosition()
    }

    // MARK: - Random Position
    func resetButtonPosition() {
        buttonX = CGFloat.random(in: 80...320)
        buttonY = CGFloat.random(in: 250...650)
    }
}

#Preview {
    NavigationStack {
        TapFrenzyView()
    }
}
