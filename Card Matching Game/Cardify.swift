//
//  Cardify.swift
//  Card Matching Game
//
//  Created by Người dùng Khách on 06/09/2023.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                if isFaceUp {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(lineWidth: 3)
                    content
                } else {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill()
                }
            }
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
