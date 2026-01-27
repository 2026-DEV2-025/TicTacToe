//
//  EngineResult.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 27/01/2026.
//


struct EngineResult {
    let type: PlayerType
    let cells: [BoardCell]?
    let rulesResult: EngineRulesResult
    
    init(type: PlayerType, cells: [BoardCell]?, rulesResult: EngineRulesResult) {
        self.type = type
        self.cells = cells
        self.rulesResult = rulesResult
    }
}
