//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Maryiam Ajlan on 27/01/2023.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
