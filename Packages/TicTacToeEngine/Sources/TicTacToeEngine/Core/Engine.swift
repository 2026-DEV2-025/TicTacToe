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
            if let winnerResult = checkWinner(for: lastPlayerMove.player.type) {
                return winnerResult
            } else {
                return .init(winningMark: .none, winningCells: nil, rulesResult: .draw)
            }
        }
        
        if rulesResult != .moveSucceeded {
            return .init(winningMark: move.player.type, winningCells: nil, rulesResult: rulesResult)
        }
        
        boardState.addMove(move)
        
        if let winResult = checkWinner(for: move.player.type) {
            return winResult
        }
        
        if boardState.boardIsFull() {
            return .init(winningMark: .none, winningCells: nil, rulesResult: .draw)
        }
        
        return .init(winningMark: .none, winningCells: nil, rulesResult: .moveSucceeded)
    }
    
    func checkWinner(for type: PlayerType) -> EngineResult? {
        
        if let rows = checkRows(for: type) {
            return .init(winningMark: type, winningCells: rows, rulesResult: .winning)
        }

        if let columns = checkColumns(for: type)  {
            return .init(winningMark: type, winningCells: columns, rulesResult: .winning)
        }
                
        if let diagonal = checkDiagonals(for: type) {
            return .init(winningMark: type, winningCells: diagonal, rulesResult: .winning)
        }
        
        return nil
    }

    //fixme: probably no need
    func boardCells(for type: PlayerType) -> [BoardCell?] {
        boardState.getCells(for: type)
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
