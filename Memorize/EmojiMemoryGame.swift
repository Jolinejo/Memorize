//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Maryiam Ajlan on 01/02/2023.
//

import Foundation
import SwiftUI


class EmojiMemoryGame: ObservableObject {
    //static let food =
    static var themeNumber = 0
    static var colorOfTheme: String = "green"
    static var nameOfTheme = "Food"
    
    static func createMamoryGame (_ numberOfPairs: Int?, _ emojis: Array<String>) -> MemoryGame<String>
    {
        colorOfTheme = themes[themeNumber].1
        nameOfTheme = themes[themeNumber].3
        
        var useablePairs = numberOfPairs
        
        if let realnumber = numberOfPairs {
            if (realnumber > emojis.count)
                {useablePairs = emojis.count}
            
        } else { useablePairs = emojis.count}
        
        return MemoryGame<String>(numberOfPairsOfCards: useablePairs!) {pairIndex in emojis[pairIndex]}
    }
    
    static var themes: Array<(Int?, String, Array<String>, String)> = [
        (5, "orange",["🍣", "🍙", "🍘", "🍥", "🥟", "🍤", "🦪", "🍚", "🥠", "🍢", "🍡", "🍰", "🍮", "🍨", "🍧", "🍪", "🌰"], "Food"),
        (4, "blue",["🇦🇹", "🇧🇹", "🇦🇶", "🇩🇿", "🇰🇾", "🇨🇿", "🇸🇻", "🇫🇷"], "Flags"),
        (6, "green", ["🚗", "🚕", "🚙", "🚎", "🚑", "🚐"], "Vehicles"),
        (5,"yellow",["😍", "🥺", "🤪", "🥵", "😒"], "Faces"),
        (4, "lemon", ["🏀", "⚾️", "🥎", "🎾", "🏉", "⚽️"], "Sports"),
        (4, "red", ["🥼", "👚", "🧣"], "Clothes")]
    
    func addNewTheme (_ number: Int?, _ themeColor: String, _ emojis: Array<String>, _ nameOfTheme: String) {
        let tupleArray = [(number, themeColor, emojis, nameOfTheme)]
            EmojiMemoryGame.themes.append(contentsOf: tupleArray)
    }
    
    @Published private var model: MemoryGame<String> = createMamoryGame(themes[themeNumber].0, themes[themeNumber].2.shuffled())
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    func ThemeColor() -> Color {
        if (EmojiMemoryGame.colorOfTheme == "orange") {return .orange}
        else if (EmojiMemoryGame.colorOfTheme == "blue") {return .blue}
        else if (EmojiMemoryGame.colorOfTheme == "green") {return .green}
        else if (EmojiMemoryGame.colorOfTheme == "yellow") {return .yellow}
        else if (EmojiMemoryGame.colorOfTheme == "red") {return .red}
        else {return .gray}
    }
    //MARK: - intent(s)
    func choose (_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame () {
        EmojiMemoryGame.themeNumber = .random(in: 0..<EmojiMemoryGame.themes.count)
        model = EmojiMemoryGame.createMamoryGame(EmojiMemoryGame.themes[EmojiMemoryGame.themeNumber].0, EmojiMemoryGame.themes[EmojiMemoryGame.themeNumber].2.shuffled())
    }
    
    func chooseTheme (_ currentNumber: Int) {
        EmojiMemoryGame.themeNumber = currentNumber
        model = EmojiMemoryGame.createMamoryGame(EmojiMemoryGame.themes[EmojiMemoryGame.themeNumber].0, EmojiMemoryGame.themes[EmojiMemoryGame.themeNumber].2.shuffled())
    }
}
