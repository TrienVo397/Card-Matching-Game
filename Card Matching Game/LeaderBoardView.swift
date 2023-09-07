//
//  LeaderBoardView.swift
//  Card Matching Game
//
//  Created by Người dùng Khách on 06/09/2023.
//

import SwiftUI

struct LeaderBoardView: View {
    @State private var playerScores: [PlayerScore] = UserDefaults.standard.getPlayerScores() ?? []

    var body: some View {
        NavigationView {
            List {
                ForEach(playerScores.sorted(by: { $0.score > $1.score }).prefix(10), id: \.id) { player in
                    HStack {
                        Text(player.name)
                            .font(.headline)
                        Spacer()
                        Text("Score: \(player.score)")
                        Text("Games Played: \(player.gamesPlayed)")
                    }
                }
            }
            .navigationBarTitle("Leaderboard", displayMode: .inline)
        }
        .onAppear {
            // Refresh the scores when the view appears
            playerScores = UserDefaults.standard.getPlayerScores() ?? []
            print(playerScores)
        }
    }
}


struct LeaderBoardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView()
    }
}
