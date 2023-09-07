//
//  MemoryGameViewModel.swift
//  Card Matching Game
//
//  Created by Người dùng Khách on 06/09/2023.
//


import Foundation

class MemoryGameViewModel: ObservableObject {
    @Published private var model: MemoryGame<String>
    @Published var remainingTime: Int
    private var gameMode: GameMode
    private var timer: Timer?
    @Published var playerName: String = ""
    @Published var gameState: GameState = .playing

        enum GameState {
            case playing, won, lost
        }

    init(gameMode: GameMode, playerName: String) {
        self.gameMode = gameMode
        self.playerName = playerName
        model = MemoryGameViewModel.createMemoryGame(gameMode: gameMode)
        self.remainingTime = gameMode.timeLimit
        startTimer()
    }

    private static func createMemoryGame(gameMode: GameMode) -> MemoryGame<String> {
        let emojis = ["🍎", "🍊", "🍋", "🍌", "🍉", "🍇"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }

    func choose(_ card: MemoryGame<String>.Card) {
           model.choose(card: card)
           if model.cards.allSatisfy({ $0.isMatched }) {
               // All cards are matched, stop the timer
               timer?.invalidate()
               gameState = .won
               savePlayerScore()
           }
       }

    func resetGame() {
        model = MemoryGameViewModel.createMemoryGame(gameMode: gameMode)
        self.remainingTime = gameMode.timeLimit
        startTimer()
    }
    
    private func startTimer() {
         timer?.invalidate() // invalidate any existing timer
         timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
             if self?.remainingTime ?? 0 > 0 {
                 self?.remainingTime -= 1
             } else {
                 self?.timer?.invalidate()
                 self?.gameState = .lost
                 // Handle game over due to time running out in the ViewModel
             }
         }
     }
    
    var score: Int {
        gameMode.scoreMultiplier * remainingTime
    }

    private func savePlayerScore() {
        var playerScores = UserDefaults.standard.getPlayerScores() ?? []
        if let index = playerScores.firstIndex(where: { $0.name == playerName }) {
            var player = playerScores[index]
            if score > player.score {
                player.score = score
            }
            player.gamesPlayed += 1
            if gameState == .won {
                player.gamesWon += 1
            }
            player.badges = updateBadges(for: player)
            playerScores[index] = player
        } else {
            let newPlayer = PlayerScore(name: playerName, score: score, gamesPlayed: 1, gamesWon: gameState == .won ? 1 : 0, badges: [])
            playerScores.append(newPlayer)
        }
        UserDefaults.standard.savePlayerScores(playerScores)
    }

    private func updateBadges(for player: PlayerScore) -> [Badge] {
        var badges = player.badges
        switch gameMode {
        case .easy:
            if player.gamesWon == 5 && !badges.contains(where: { $0.name == "beginnerluck" }) {
                badges.append(Badge(name: "beginnerluck", imageName: "beginnerluck_image"))
            }
            if player.gamesWon == 10 && !badges.contains(where: { $0.name == "masterluck" }) {
                badges.append(Badge(name: "masterluck", imageName: "masterluck_image"))
            }
        case .medium:
            if player.gamesWon == 5 && !badges.contains(where: { $0.name == "medium player" }) {
                badges.append(Badge(name: "medium player", imageName: "mediumplayer_image"))
            }
            if player.gamesWon == 10 && !badges.contains(where: { $0.name == "skillful player" }) {
                badges.append(Badge(name: "skillful player", imageName: "skillfulplayer_image"))
            }
        case .hard:
            if player.gamesWon == 5 && !badges.contains(where: { $0.name == "skillfulmaster" }) {
                badges.append(Badge(name: "skillfulmaster", imageName: "skillfulmaster_image"))
            }
            if player.gamesWon == 10 && !badges.contains(where: { $0.name == "suprememaster" }) {
                badges.append(Badge(name: "suprememaster", imageName: "suprememaster_image"))
            }
        }
        return badges
    }
}
