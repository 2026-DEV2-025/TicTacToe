//
//  BoardState.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 26/01/2026.
//

protocol BoardState {
    init(moves: [PlayerMove])
    var moves: [PlayerMove] { get }
}

final class BoardStateImpl: BoardState {
    let moves: [PlayerMove]
    
    init(moves: [PlayerMove]) {
        self.moves = moves
    }
}
