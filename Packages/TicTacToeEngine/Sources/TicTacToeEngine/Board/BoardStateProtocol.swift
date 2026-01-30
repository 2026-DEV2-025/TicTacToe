//
//  BoardStateProtocol.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 30/01/2026.
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
