//
//  EngineResult.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 27/01/2026.
//


struct EngineResult {
    let winningMark: PlayerType
    let winningCells: [BoardCell]?
    let rulesResult: EngineRulesResult
    
    init(winningMark: PlayerType, winningCells: [BoardCell]?, rulesResult: EngineRulesResult) {
        self.winningMark = winningMark
        self.winningCells = winningCells
        self.rulesResult = rulesResult
    }
}
