//
//  BoardState.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 26/01/2026.
//

protocol BoardState {
    init(moves: [PlayerMove], board: Board)
    var moves: [PlayerMove] { get }
}

final class BoardStateImpl: BoardState {
    let moves: [PlayerMove]
    let board: Board
    
    init(moves: [PlayerMove], board: Board) {
        self.moves = moves
        self.board = board
    }
}
