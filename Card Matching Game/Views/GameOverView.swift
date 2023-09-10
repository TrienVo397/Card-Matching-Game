//
//  GameOverView.swift
//  Card Matching Game
//
//  Created by Người dùng Khách on 08/09/2023.
//

import SwiftUI

struct GameOverView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack{
            Image("purpleBg")
                .resizable()
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            Image("gameOver")
                .resizable()
                .padding(/*@START_MENU_TOKEN@*/.all, 20.0/*@END_MENU_TOKEN@*/)
                .scaledToFit()
            VStack {
                Spacer()
//                NavigationLink(destination: MenuView()) {
//                    Text("OK!")
//                        .frame(width: 130, height: 20)
//                        .font(.headline)
//                        .padding()
//                        .background(Color.green)
//                        .foregroundColor(.white)
//                        .cornerRadius(20)
//                    
//                }
                Button {
                    dismiss()
                } label: {
                    Text("OK!")
                        .frame(width: 130, height: 20)
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                
            }
        }
        
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
    }
}
