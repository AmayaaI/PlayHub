import Foundation
import SwiftUI
import Combine

@MainActor
final class QuizRushVM: ObservableObject {
    
    enum State {
        case loading
        case loaded
        case failed(String)
        case finished
    }
    
    @Published var state: State = .loading
    
    @Published var questions: [TriviaQuestion] = []
    @Published var index: Int = 0
    @Published var score: Int = 0
    @Published var streak: Int = 0
    @Published var correctCount: Int = 0
    
    @AppStorage("quizHighScore")
    var highScore = 0
    
    var currentQuestion: TriviaQuestion? {
        guard index < questions.count else { return nil }
        return questions[index]
    }
    
    func load() async {
        state = .loading
        
        do {
            let fetched = try await TriviaAPI.shared.fetchQuestions()
            
            questions = fetched
            index = 0
            score = 0
            streak = 0
            correctCount = 0
            
            state = .loaded
        } catch {
            state = .failed("Failed to load quiz. Check internet.")
        }
    }
    
    func answer(_ selected: String) {
        
        guard let question = currentQuestion else { return }
        
        let isCorrect = selected == question.correct_answer
        
        if isCorrect {
            streak += 1
            correctCount += 1
            score += 10 + (streak * 2)
        } else {
            streak = 0
            score -= 2
        }
        
        next()
    }
    
    private func next() {
        index += 1
        
        if index >= questions.count {
            state = .finished
            saveSession()
        }
    }
    
    func retry() async {
        await load()
    }
    private func saveSession() {
        
        // Update personal best
        
        if score > highScore {
            
            highScore = score
            
        }
        
        
        let session = GameSession(
            id: UUID(),
            mode: .quizRush,
            score: score,
            timestamp: Date(),
            latitude: LocationService.shared.latitude,
            longitude: LocationService.shared.longitude
        )
        
        
        GameStorage.shared.saveSession(session)
        
    }
}
