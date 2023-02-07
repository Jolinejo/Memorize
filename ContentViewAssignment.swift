//
//  ContentView.swift
//  Memorize
//
//  Created by Maryiam Ajlan on 27/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = [["🍣", "🍙", "🍘", "🍥", "🥟", "🍤", "🦪", "🍚", "🥠", "🍢", "🍡", "🍰", "🍮", "🍨", "🍧", "🍪", "🌰"], ["🐑", "🐄", "🐕", "🐈", "🐕‍🦺", "🦓", "🦈", "🐩", "🐿", "🐇", "🐫", "🐋"], ["🏳️", "🇩🇿", "🇪🇬", "🇫🇴", "🇩🇲", "🇩🇴", "🇨🇩", "🇨🇨", "🇬🇩", "🇬🇬", "🇯🇵"]]
    @State var emojicount = 8
    @State var ind = 0
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .foregroundColor(Color.red)
            ScrollView {
                LazyVGrid (columns: [GridItem(.adaptive(minimum: minwidth(numberofcards: Double(emojicount))))]) {
                    ForEach (emojis[ind][0..<emojicount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                food
                Spacer()
                animals
                Spacer()
                flags
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
        
    }
    
    var food: some View {
        Button{
            emojicount=Int.random(in: 7...emojis[0].count)
            emojis[0]=emojis[0].shuffled()
            ind = 0
        } label: {
            VStack {
                Image(systemName: "fork.knife.circle")
                Text("Food")
                    .font(.body)
            }
        }
    }
    var animals: some View {
        Button{
            emojicount=Int.random(in: 7...emojis[1].count)
            emojis[1]=emojis[1].shuffled()
            ind = 1
        } label: {
            VStack{
                Image(systemName: "pawprint.circle")
                Text("Animals")
                    .font(.body)
            }
        }
    }
    
    var flags: some View {
        Button{
            emojicount=Int.random(in: 7...emojis[2].count)
            emojis[2]=emojis[2].shuffled()
            ind = 2
        } label: {
            VStack {
                Image(systemName: "flag.circle")
                Text("Flags")
                    .font(.body)
            }
        }
    }
}
func minwidth (numberofcards: Double) -> CGFloat  {
    let x = CGFloat(300/ceil(sqrt(numberofcards)))
    if x >= 65 {
        return x
    } else { return 65
        
    }
}
struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}




















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
        ContentView()
            .preferredColorScheme(.light)
            
    }
}
