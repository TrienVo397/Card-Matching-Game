//
//  User.swift
//  Card Matching Game
//
//  Created by Người dùng Khách on 06/09/2023.
//

import Foundation
struct User: Identifiable, Codable {
    var id: UUID = UUID()
    var username: String
    var highScore: Int = 0
    var gamesPlayed: Int = 0
    var gamesWon: Int = 0

    var winPercentage: Double {
        return gamesPlayed == 0 ? 0 : (Double(gamesWon) / Double(gamesPlayed)) * 100
    }
}
