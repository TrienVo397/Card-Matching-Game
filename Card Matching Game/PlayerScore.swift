//
//  DataManager.swift
//  Card Matching Game
//
//  Created by Người dùng Khách on 06/09/2023.
//

import Foundation


struct PlayerScore: Codable, Identifiable {
    var id = UUID()
    var name: String
    var score: Int
    var gamesPlayed: Int
    var gamesWon: Int
    var badges: [Badge]
    
    var winPercentage: Double {
        return (gamesPlayed == 0) ? 0 : (Double(gamesWon) / Double(gamesPlayed)) * 100
    }
    
    mutating func updateBadges(for gameMode: GameMode) {
        switch gameMode {
        case .easy:
            if gamesWon == 5 {
                let badge = Badge(name: "Beginner Luck", imageName: "beginnerluck")
                if !badges.contains(where: { $0.name == badge.name }) {
                    badges.append(badge)
                }
            } else if gamesWon == 10 {
                let badge = Badge(name: "Master Luck", imageName: "masterluck")
                if !badges.contains(where: { $0.name == badge.name }) {
                    badges.append(badge)
                }
            }
        case .medium:
            if gamesWon == 5 {
                let badge = Badge(name: "Medium Player", imageName: "mediumplayer")
                if !badges.contains(where: { $0.name == badge.name }) {
                    badges.append(badge)
                }
            } else if gamesWon == 10 {
                let badge = Badge(name: "Skillful Player", imageName: "skillfulplayer")
                if !badges.contains(where: { $0.name == badge.name }) {
                    badges.append(badge)
                }
            }
        case .hard:
            if gamesWon == 5 {
                let badge = Badge(name: "Skillful Master", imageName: "skillfulmaster")
                if !badges.contains(where: { $0.name == badge.name }) {
                    badges.append(badge)
                }
            } else if gamesWon == 10 {
                let badge = Badge(name: "Supreme Master", imageName: "suprememaster")
                if !badges.contains(where: { $0.name == badge.name }) {
                    badges.append(badge)
                }
            }
        }
    }
}

struct Badge: Codable, Identifiable {
    var id = UUID()
    var name: String
    var imageName: String
}




extension UserDefaults {
    func savePlayerScores(_ playerScores: [PlayerScore]) {
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
