//
//  Engine.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 26/01/2026.
//


class Engine {
    private let boardState: BoardState
    private let engineRules: EngineRules
    
    init(boardState: BoardState, engineRules: EngineRules) {
        self.boardState = boardState
        self.engineRules = engineRules
    }
    
    func makeMove(by move:PlayerMove) -> EngineResult {
        let rulesResult = engineRules.checkMoveIsValid(move:move)
        
        if rulesResult == .noMoreMovesAllowedError {
            let lastPlayerMove = boardState.moves.last!
            return checkWinner(for: lastPlayerMove.player.type)
        }
        
        if rulesResult != .moveSucceeded {
            return .init(type: move.player.type, cells: nil, rulesResult: rulesResult)
        }
        
        boardState.addMove(move)
        
        return checkWinner(for: move.player.type)
    }
    
    func checkWinner(for type: PlayerType) -> EngineResult {
        
        if let rows = checkRows(for: type) {
            return .init(type: type, cells: rows, rulesResult: .moveSucceeded)
        }

        if let columns = checkColumns(for: type)  {
            return .init(type: type, cells: columns, rulesResult: .moveSucceeded)
        }
                
        if let diagonal = checkDiagonals(for: type) {
            return .init(type: type, cells: diagonal, rulesResult: .moveSucceeded)
        }
        
        return .init(type: .none, cells: nil, rulesResult: .moveSucceeded)
    }
}

private extension Engine {
    func checkRows(for type: PlayerType) -> [BoardCell]? {
        let cells = boardState.getCells(for: type)
        return winningLine(in: cells, lineLength: boardState.boardSize)
    }
    
    func checkColumns(for type: PlayerType) -> [BoardCell]? {
        guard let cells = boardState.getCells(for: type).transposed() else {
            return nil
        }
        return winningLine(in: cells, lineLength: boardState.boardSize)
    }
    
    func checkDiagonals(for type: PlayerType) -> [BoardCell]? {
        guard
            let cellsDiagonal = boardState.getCells(for: type).diagonalTopLeftToBottomRight(),
            let cellsAntiDiagonal = boardState.getCells(for: type).diagonalTopRightToBottomLeft()
        else {
            return nil
        }
        
        if let line = winningLine(in: cellsDiagonal, lineLength: boardState.boardSize) {
            return line
        }
        
        return winningLine(in: cellsAntiDiagonal, lineLength: boardState.boardSize)
    }
    
    func winningLine(in cells: [BoardCell?], lineLength: Int) -> [BoardCell]? {
        var winningLine = [BoardCell]()
        for (i, cell) in cells.enumerated() {
            if i % lineLength == 0  {
                winningLine.removeAll()
            }
            
            guard let cell else {
                winningLine.removeAll()
                continue
            }

            winningLine.append(cell)
            
            if winningLine.count == lineLength {
                return winningLine
            }
        }
        
        return nil
    }
}
