//
//  TriviaAPI.swift
//  PlayHub
//
//  Created by Amaya Mahavithane on 2026-07-06.
//

import Foundation

final class TriviaAPI {

    static let shared = TriviaAPI()
    private init() {}

    func fetchQuestions() async throws -> [TriviaQuestion] {

        let url = URL(string: "https://opentdb.com/api.php?amount=10&type=multiple")!

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoded = try JSONDecoder().decode(TriviaResponse.self, from: data)

        return decoded.results
    }
}
