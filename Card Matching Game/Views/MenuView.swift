import SwiftUI

struct MenuView: View {
    @State private var selectedGameMode: GameMode = .easy
    @State private var isShowingGameView: Bool = false
    @State private var playerName: String = ""

    // Define a fixed size for all buttons
    let buttonWidth: CGFloat =  130
    let buttonHeight: CGFloat = 20

    var body: some View {
        NavigationStack {
            ZStack {
                Image("greenBg")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(width: UIScreen.main.bounds.width)
                VStack(spacing: 30) {
                    Spacer()
                        
                    Image("cardmemory")
                        .resizable()
                        .padding(.horizontal, 20.0)
                        .scaledToFit()
                    Image("matchinggame")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal,20)
                    
                    Spacer()
                    TextField("Enter your name to start", text: $playerName)
                        .frame(width: 200, height: 20)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.horizontal)
                        
                    
                    Button(action: {
                        isShowingGameView = true
                    }) {
                        Text("START GAME")
                            .frame(width: buttonWidth, height: buttonHeight)
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .frame(width: buttonWidth, height: buttonHeight)
                    }
                    
                    .disabled(playerName.isEmpty)
                    .opacity(playerName.isEmpty ? 0.3 : 1.0)
                    .fullScreenCover(isPresented: $isShowingGameView) {
                        EmojiMemoryGameView(viewModel: MemoryGameViewModel(gameMode: selectedGameMode, playerName: playerName), playerName: $playerName)
                    }

                    NavigationLink(destination: LeaderBoardView()) {
                        Text("LEADERBOARD")
                            .frame(width: buttonWidth, height: buttonHeight)
                            .font(.headline)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            
                    }
                    

                    NavigationLink(destination: Text("How To Play View")) {
                        Text("HOW TO PLAY")
                            .frame(width: buttonWidth, height: buttonHeight)
                            .font(.headline)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            
                    }
                    .frame(width: buttonWidth, height: buttonHeight)

                    NavigationLink(destination: GameSettingsView(selectedGameMode: $selectedGameMode)) {
                        Text("SETTINGS")
                            .frame(width: buttonWidth, height: buttonHeight)
                            .font(.headline)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            
                    }
                    

                    Spacer()
                }
                
            }
        }
    }
}


struct GameSettingsView: View {
    @Binding var selectedGameMode: GameMode

    var body: some View {
        ZStack {
            Image("greenBg")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
        
                Text("Select Game Difficulty")
                    .font(.headline)
                    .padding()

                Picker("Difficulty", selection: $selectedGameMode) {
                    Text("Easy").tag(GameMode.easy)
                    Text("Medium").tag(GameMode.medium)
                    Text("Hard").tag(GameMode.hard)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Spacer()
            }
        }
    }
}
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
