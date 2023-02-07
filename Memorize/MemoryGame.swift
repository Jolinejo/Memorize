//
//  MemoryGame.swift
//  Memorize
//
//  Created by Maryiam Ajlan on 01/02/2023.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private (set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    private (set) var score: Int = 0
    
    private var PrevDate : Date?
    
    private var CurrDate: Date?
    
    mutating func choose(_ card: Card) {
        let dateNow = Date.now
        if CurrDate != nil {
            PrevDate = CurrDate
            CurrDate = dateNow
        } else {CurrDate = dateNow}
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}), !cards[chosenIndex].isMatched, !cards[chosenIndex].isFaceUp
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += max((10 - Int(CurrDate!.timeIntervalSince(PrevDate!)))*2,2)
                    
                } else if (cards[chosenIndex].wasSeen) {
                    score -= 1
                    if (cards[potentialMatchIndex].wasSeen) {
                        score -= 1
                    }
                } else if (cards[potentialMatchIndex].wasSeen) {
                    score -= 1
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
                cards[chosenIndex].wasSeen = true
                cards[potentialMatchIndex].wasSeen = true
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsOfCards * 2
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards = cards.shuffled()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var wasSeen: Bool = false
        var id: Int
    }
}
