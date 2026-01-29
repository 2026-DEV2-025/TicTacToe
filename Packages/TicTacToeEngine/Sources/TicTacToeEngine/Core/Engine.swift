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
    
    func makeMove(by move:BoardCell) -> EngineResult {
        let rulesResult = engineRules.checkMoveIsValid(move:move)
        
        if rulesResult == .noMoreMovesAllowedError {
            let lastBoardCell = boardState.moves.last!
            if let winnerResult = checkWinner(for: lastBoardCell.type) {
                return winnerResult
            } else {
                return .init(winningMark: .none, winningCells: nil, rulesResult: .draw)
            }
        }
        
        if rulesResult != .moveSucceeded {
            return .init(winningMark: move.type, winningCells: nil, rulesResult: rulesResult)
        }
        
        boardState.addMove(move)
        
        if let winResult = checkWinner(for: move.type) {
            return winResult
        }
        
        if boardState.boardIsFull() {
            return .init(winningMark: .none, winningCells: nil, rulesResult: .draw)
        }
        
        return .init(winningMark: .none, winningCells: nil, rulesResult: .moveSucceeded)
    }
    
    func checkWinner(for type: CellMarkType) -> EngineResult? {
        
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

    func boardCells() -> [BoardCell] {
        boardState.getCells(for: nil)
    }
    
    func emptyCells() -> [BoardCell] {
        boardState.getCells(for: nil).filter { $0.type == .none }
    }
}

private extension Engine {
    func cellsForType(_ type: CellMarkType) -> [CellCoordinate?] {
        return boardState.getCells(for: type).map { cell in
            cell.type == type ? cell.cell : nil
        }
    }

    func checkRows(for type: CellMarkType) -> [CellCoordinate]? {
        let cells = cellsForType(type)
        return winningLine(in: cells, lineLength: boardState.boardSize)
    }
    
    func checkColumns(for type: CellMarkType) -> [CellCoordinate]? {
        guard let cells = cellsForType(type).transposed() else {
            return nil
        }
        return winningLine(in: cells, lineLength: boardState.boardSize)
    }
    
    func checkDiagonals(for type: CellMarkType) -> [CellCoordinate]? {
        guard
            let cellsDiagonal = cellsForType(type).diagonalTopLeftToBottomRight(),
            let cellsAntiDiagonal = cellsForType(type).diagonalTopRightToBottomLeft()
        else {
            return nil
        }
        
        if let line = winningLine(in: cellsDiagonal, lineLength: boardState.boardSize) {
            return line
        }
        
        return winningLine(in: cellsAntiDiagonal, lineLength: boardState.boardSize)
    }
    
    func winningLine(in cells: [CellCoordinate?], lineLength: Int) -> [CellCoordinate]? {
        var winningLine = [CellCoordinate]()
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
