//
//  EngineRules.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 26/01/2026.
//

struct EngineRulesImpl: EngineRules {
    let boardState: BoardState
    
    var lastMove: BoardCell? {
        boardState.moves.last
    }
        
    init(boardState: BoardState) {
        self.boardState = boardState
    }
    
    func checkMoveIsValid(move: BoardCell) -> EngineRulesResult {
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
    private func checkFirstMove(for move: BoardCell) -> Bool {
        if boardState.moves.count == 0 {
            if move.type != .x {
                return false
            }
        }
        return true
    }
    
    private func alreadyPlayedPosition(for move: BoardCell) -> Bool {
        if boardState.moves.contains(where: { $0.cell == move.cell }) {
            return true
        }
        return false
    }
    
    private func isAlternatePlayer(for move: BoardCell) -> Bool {
        guard let lastMove else {
            return true
        }
        return lastMove.type != move.type
    }
    
    private func noMoreMovesAllowed() -> Bool {
        boardState.moves.count >= boardState.boardSize * boardState.boardSize
    }
}
