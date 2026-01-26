//
//  EngineRules.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 26/01/2026.
//

enum EngineRulesResult {
    case moveSucceeded
    case onlyXMustStartError
    case invalidMoveError
}

protocol EngineRules {
    func checkMoveIsValid(move: PlayerMove) -> EngineRulesResult
}

struct EngineRulesImpl: EngineRules {
    let boardState: BoardState
    
    init(boardState: BoardState) {
        self.boardState = boardState
    }
    
    func checkMoveIsValid(move: PlayerMove) -> EngineRulesResult {
        
        if !checkFirstMove(for: move) {
            return .onlyXMustStartError
        }
        
        return .moveSucceeded
    }
}

extension EngineRulesImpl {
    private func checkFirstMove(for move: PlayerMove) -> Bool {
        if boardState.moves.count == 0 {
            if move.player.type != .x {
                return false
            }
        }
        return true
    }
}
