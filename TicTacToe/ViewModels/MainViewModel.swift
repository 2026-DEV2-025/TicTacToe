//
//  MainViewModel.swift
//  TicTacToe
//
//  Created by 2026-DEV2-025 on 29/01/2026.
//

import SwiftUI
import TicTacToeEngine
import Combine


@MainActor
final class MainViewModel: ObservableObject {
    let boardViewModel: BoardViewModel
    let engine: TicTacToeEngine
    let boardSize: Int
    
    init(engine: TicTacToeEngine, boardSize: Int) {
        self.engine = engine
        self.boardSize = boardSize
        self.boardViewModel = BoardViewModel(engine: engine, boardSize: boardSize)
    }

    convenience init(boardSize: Int = 3) {
        let engine = TicTacToeEngine(boardSize: boardSize)
        self.init(engine: engine, boardSize: boardSize)
    }
    
    func restartGame() {
        boardViewModel.reset()
    }
}
