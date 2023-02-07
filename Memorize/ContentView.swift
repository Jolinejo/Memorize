//
//  ContentView.swift
//  Memorize
//
//  Created by Maryiam Ajlan on 27/01/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        VStack{
            Text(EmojiMemoryGame.nameOfTheme)
                .font(.largeTitle)
            Text("Score is: \(viewModel.score)")
                .font(.title)
            ScrollView {
                LazyVGrid (columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach (viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .padding(.horizontal)
            Spacer()
            newGame
        }
        .font(.largeTitle)
        .padding(.horizontal)
        .foregroundColor(viewModel.ThemeColor())
    }
    
    var newGame: some View {
        Button{
            viewModel.newGame()
        } label: {
            VStack {
                Text("New Game")
                    .font(.title2)
                    .padding()
                
            }
        }
    }
    
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}




















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
            
    }
}
