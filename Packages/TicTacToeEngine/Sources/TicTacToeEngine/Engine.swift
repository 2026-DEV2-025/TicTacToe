//
//  Engine.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 26/01/2026.
//


protocol Engine {
    init(boardState: BoardState, engineRules: EngineRules)
    func playerMove(move: PlayerMove) -> EngineRulesResult
}

final class EngineImpl: Engine {
    let boardState: BoardState
    let engineRules: EngineRules
    
    init(boardState: BoardState, engineRules: EngineRules) {
        self.boardState = boardState
        self.engineRules = engineRules
    }
    
    func playerMove(move: PlayerMove) -> EngineRulesResult {
        return engineRules.checkMoveIsValid(move: move)
    }
}
