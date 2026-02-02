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
            let BOARD_SIZE: Int = 3
            MainView(mainViewModel: MainViewModel(engine: TicTacToeEngine(boardSize: BOARD_SIZE), boardSize: BOARD_SIZE))
        }
    }
}
