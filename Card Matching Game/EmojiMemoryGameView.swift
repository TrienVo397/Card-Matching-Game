//
//  CardView.swift
//  Card Matching Game
//
//  Created by Người dùng Khách on 06/09/2023.
//

import SwiftUI
struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: MemoryGameViewModel
    @Binding var playerName: String
    
    var body: some View {
        VStack {
            HStack {
                switch viewModel.gameState {
                            case .playing:
                                EmptyView() // No message while playing
                            case .won:
                                Text("You Win!")
                                    .font(.largeTitle)
                                    .foregroundColor(.green)
                                    .padding()
                            case .lost:
                                Text("Game Over!")
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                                    .padding()
                            }
                Text("Time: \(viewModel.remainingTime)")
                    .font(.headline)
                    .padding()
                
                Spacer()
                
                Text(playerName)
                    .font(.title)
                    .padding()
                
                Spacer()
                
                Text("Score: \(viewModel.score)")
                    .font(.headline)
                    .padding()
            }
            
            Grid(items: viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        viewModel.choose(card)
                    }
                }
                .padding(5)
            }
            
            .padding()
            .foregroundColor(Color.orange) // Adjust the color as per your theme
            
            Button(action: {
                withAnimation(.easeInOut) {
                    viewModel.resetGame()
                }
            }, label: {
                Text("New Game")
                    .font(.headline)
            })
        }
        .navigationTitle("Memory Game")
        .navigationBarItems(trailing: Text("Score: \(viewModel.score)"))
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(lineWidth: 3)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.7
    }
}
struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: MemoryGameViewModel(gameMode: .easy, playerName: "John Doe"), playerName: .constant("John Doe"))
    }
}
