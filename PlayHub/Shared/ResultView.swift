//
//  ResultView.swift
//  PlayHub
//
//  Created by Amaya Mahavithane on 2026-07-06.
//

import SwiftUI

struct ResultView: View {

    let mode: String
    let score: Int

    var body: some View {

        VStack(spacing:20){

            Text("Final Score")

            Text("\(score)")
                .font(.system(size:70))
                .bold()

            ShareLink(
                item: "I just scored \(score) on \(mode)! Beat that!"
            )

        }

    }

}
