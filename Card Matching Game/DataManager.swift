//
//  DataManager.swift
//  Card Matching Game
//
//  Created by Người dùng Khách on 06/09/2023.
//

import Foundation
struct PlayerScore: Codable {
    var name: String
    var score: Int
}

class DataManager {
    static let playerScoresKey = "PlayerScores"

    static func save(_ playerScore: PlayerScore) {
        var scores = fetchAllScores()
        scores.append(playerScore)
        if let encodedData = try? JSONEncoder().encode(scores) {
            UserDefaults.standard.set(encodedData, forKey: playerScoresKey)
        }
    }

    static func fetchAllScores() -> [PlayerScore] {
        if let savedData = UserDefaults.standard.data(forKey: playerScoresKey),
           let decodedScores = try? JSONDecoder().decode([PlayerScore].self, from: savedData) {
            return decodedScores
        }
        return []
    }
}
