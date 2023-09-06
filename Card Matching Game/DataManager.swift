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

extension UserDefaults {
    func savePlayerScore(_ playerScore: PlayerScore) {
        var playerScores = getPlayerScores() ?? []
        playerScores.append(playerScore)
        if let encodedData = try? JSONEncoder().encode(playerScores) {
            UserDefaults.standard.set(encodedData, forKey: "playerScores")
        }
    }
    
    func getPlayerScores() -> [PlayerScore]? {
        if let savedData = UserDefaults.standard.data(forKey: "playerScores"),
           let decodedData = try? JSONDecoder().decode([PlayerScore].self, from: savedData) {
            return decodedData
        }
        return nil
    }
}


