//
//  LeaderBoardView.swift
//  Card Matching Game
//
//  Created by Người dùng Khách on 06/09/2023.
//

import Foundation
import SwiftUI
struct LeaderBoardView: View {
    var playerScores: [PlayerScore] = UserDefaults().getPlayerScores() ?? []

    var body: some View {
        NavigationView {
            List(playerScores, id: \.name) { playerScore in
                HStack {
                    Text(playerScore.name)
                        .font(.headline)
                    Spacer()
                    Text("\(playerScore.score)")
                        .font(.subheadline)
                }
            }
            .navigationTitle("Leaderboard")
        }
    }
}

struct LeaderBoardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView()
    }
}
