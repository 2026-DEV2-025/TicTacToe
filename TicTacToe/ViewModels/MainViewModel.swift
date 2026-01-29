//
//  MainViewModel.swift
//  TicTacToe
//
//  Created by 2026-DEV2-025 on 29/01/2026.
//

import SwiftUI
import TicTacToeEngine

@MainActor
final class MainViewModel: ObservableObject {
    let boardSize: Int
    let engine: Engine

    init(engine: Engine, boardSize: Int) {
        self.engine = engine
        self.boardSize = boardSize
    }

    convenience init(boardSize: Int = 3) {
        let boardState = BoardStateImpl(moves: [], boardSize: boardSize)
        let rules = EngineRulesImpl(boardState: boardState)
        let engine = Engine(boardState: boardState, engineRules: rules)
        self.init(engine: engine, boardSize: boardSize)
    }
}
