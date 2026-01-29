//
//  BoardState.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 26/01/2026.
//

protocol BoardState {
    init(moves: [BoardCell], boardSize: Int)
    var moves: [BoardCell] { get }
    var boardSize: Int { get }
    var lastPlayedMove: BoardCell? { get }
    func addMove(_ move: BoardCell)
    func getCells(for type: CellMarkType?) -> [BoardCell]
    func boardIsFull() -> Bool
    func prettyPrintCells()
}

final class BoardStateImpl: BoardState {
    
    private var _moves: [BoardCell]
    internal let boardSize: Int
    
    init(moves: [BoardCell], boardSize: Int) {
        _moves = moves
        precondition(_moves.count <= boardSize * boardSize, "There is no more empty cells on the board")
        self.boardSize = boardSize
    }

    var moves: [BoardCell] {
        get { return _moves }
        set { self._moves = newValue }
    }

    var lastPlayedMove: BoardCell? {
        return moves.last
    }

    func addMove(_ move: BoardCell) {
        precondition(_moves.count <= boardSize * boardSize, "There is no more empty cells on the board")
        _moves.append(move)
    }
    
    func boardIsFull() -> Bool {
        return moves.count == boardSize * boardSize
    }

    func getCells(for type: CellMarkType? = nil) -> [BoardCell] {
        var boardCells: [BoardCell] = []
        for i in 0..<boardSize {
            for j in 0..<boardSize {
                let boardCellInMoves = moves.first { move in
                    guard move.cell.row == i && move.cell.column == j else {
                        return false
                    }
                    guard let type else {
                        return true
                    }
                    return move.type == type
                }
                if let boardCellInMoves {
                    boardCells.append(boardCellInMoves)
                } else {
                    boardCells.append(.init(type: .none, toCell: .init(row: i, column: j)))
                }
            }
        }
        return boardCells
    }

    func prettyPrintCells() {
        var rows = [String]()
        for rowIndex in 0..<boardSize {
            var rowMarks = [String]()
            for colIndex in 0..<boardSize {
                if let type: CellMarkType = moves.first(
                    where: { $0.cell.row == rowIndex && $0.cell.column == colIndex }
                )?.type {
                    
                    switch type {
                    case .x:
                        rowMarks.append("x")
                    case .o:
                        rowMarks.append("o")
                    case .none:
                        rowMarks.append(" ")
                    }
                } else {
                    rowMarks.append(" ")
                }
            }
            rows.append("| " + rowMarks.joined(separator: " | ") + " |")
        }

        print(rows.joined(separator: "\n"))
    }
}
