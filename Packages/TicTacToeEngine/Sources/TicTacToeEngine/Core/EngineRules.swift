//
//  EngineRules.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 26/01/2026.
//

protocol EngineRules {
    func checkMoveIsValid(move: PlayerMove) -> EngineRulesResult
}

struct EngineRulesImpl: EngineRules {
    let boardState: BoardState
    
    var lastMove: PlayerMove? {
        boardState.moves.last
    }
        
    init(boardState: BoardState) {
        self.boardState = boardState
    }
    
    func checkMoveIsValid(move: PlayerMove) -> EngineRulesResult {
        guard checkFirstMove(for: move) else {
            return .onlyXMustStartError
        }
        
        guard !alreadyPlayedPosition(for: move) else {
            return .cellIsAlreadyTakenError
        }
        
        guard isAlternatePlayer(for: move) else {
            return .mustAlternateTurnsError
        }
        
        guard !noMoreMovesAllowed() else {
            return .noMoreMovesAllowedError
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
    
    private func alreadyPlayedPosition(for move: PlayerMove) -> Bool {
        if boardState.moves.contains(where: { $0.cell == move.cell }) {
            return true
        }
        return false
    }
    
    private func isAlternatePlayer(for move: PlayerMove) -> Bool {
        guard let lastMove else {
            return true
        }
        return lastMove.player.type != move.player.type
    }
    
    private func noMoreMovesAllowed() -> Bool {
        boardState.moves.count >= BOARD_SIZE * BOARD_SIZE
    }
}
