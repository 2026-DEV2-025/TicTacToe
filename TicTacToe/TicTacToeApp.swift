//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by 2026-DEV2-025 on 21/01/2026.
//

import SwiftUI
import TicTacToeEngine

@main
struct TicTacToeApp: App {
    var body: some Scene {
        WindowGroup {
            let boardSize: Int = 3
            MainView(mainViewModel: MainViewModel(engine: TicTacToeEngine(boardSize: 3), boardSize: boardSize))
        }
    }
}
