//
//  ScoreBadge.swift
//  PlayHub
//
//  Created by Amaya Mahavithane on 2026-07-06.
//

import SwiftUI

struct ScoreBadge: View {

    let score: Int

    var body: some View {

        Text("Score: \(score)")
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())

    }

}
