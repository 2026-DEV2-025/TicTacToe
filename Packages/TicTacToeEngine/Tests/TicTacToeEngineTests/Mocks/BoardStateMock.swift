//
//  BoardStateMock.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 26/01/2026.
//

@testable import TicTacToeEngine

final class BoardStateMock: BoardState {
    var moves: [PlayerMove]
    
    init(moves: [PlayerMove]) {
        self.moves = moves
    }
}
