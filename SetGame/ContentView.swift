//
//  ContentView.swift
//  SetGame
//
//  Created by Акбар Уметов on 22.11.2021.
//

import SwiftUI

struct ContentView: View {
    @State var symbols = ["▲", "◼︎", "●", "△", "◻︎", "○",
                          "▲▲", "◼︎◼︎", "●●", "△△", "◻︎◻︎", "○○",
                          "▲▲▲", "◼︎◼︎◼︎", "●●●", "△△△", "◻︎◻︎◻︎", "○○○"]
    let symbolsCount = 12
    
    var body: some View {
        VStack {
            Text("Set").font(.largeTitle).foregroundColor(.blue)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(symbols[0..<symbolsCount], id:\.self) { symbol in
                        CardView(content: symbol).aspectRatio(2/3, contentMode: .fit)
                    }
                }.padding()
            }
            
            Spacer()
            
            newGame
            
        }
    }
    
    var newGame: some View {
        Button(action: {
            symbols.shuffle()
        }, label: {
            Image(systemName: "play.circle").font(.largeTitle)
        })
    }
}

struct CardView: View {
    let content: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                
                Text(content).font(font(in: geometry.size))
            }.foregroundColor(.blue)
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.3
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.portrait)
    }
}
