//
//  BoardState.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 26/01/2026.
//

protocol BoardState {
    init(moves: [PlayerMove], boardSize: Int)
    var moves: [PlayerMove] { get }
    var boardSize: Int { get }
    var lastPlayedMove: PlayerMove? { get }
    func addMove(_ move: PlayerMove)
    func getCells(for type: PlayerType) -> [BoardCell?]
    
}

final class BoardStateImpl: BoardState {

    private var _moves: [PlayerMove]
    internal let boardSize: Int
    
    init(moves: [PlayerMove], boardSize: Int) {
        _moves = moves
        precondition(_moves.count <= boardSize * boardSize, "There is no more empty cells on the board")
        self.boardSize = boardSize
    }

    var moves: [PlayerMove] {
        get { return _moves }
        set { self._moves = newValue }
    }

    var lastPlayedMove: PlayerMove? {
        return moves.last
    }

    func addMove(_ move: PlayerMove) {
        precondition(_moves.count <= boardSize * boardSize, "There is no more empty cells on the board")
        _moves.append(move)
    }
    
    func getCells(for type: PlayerType) -> [BoardCell?] {
        var cells = [BoardCell?]()
        for rowIndex in 0..<boardSize {
            for colIndex in 0..<boardSize {
                let move = moves.first(
                    where: {
                        $0.cell.row == rowIndex && $0.cell.column == colIndex
                        && $0.player.type == type
                    })
                cells.append(move?.cell)
            }
        }
        return cells
    }
}
