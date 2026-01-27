//
//  BoardState.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 26/01/2026.
//

protocol BoardState {
    init(moves: [PlayerMove])
    var moves: [PlayerMove] { get }
    func addMove(_ move: PlayerMove)
    func getCells(for type: PlayerType) -> [BoardCell?]
}

final class BoardStateImpl: BoardState {
    
    private var _moves: [PlayerMove]
    
    init(moves: [PlayerMove]) {
        _moves = moves
    }

    var moves: [PlayerMove] {
        get { return _moves }
        set { self._moves = newValue }
    }

    func addMove(_ move: PlayerMove) {
        _moves.append(move)
    }
    
    func getCells(for type: PlayerType) -> [BoardCell?] {
        var cells = [BoardCell?]()
        for rowIndex in 0..<BOARD_SIZE {
            for colIndex in 0..<BOARD_SIZE {
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
