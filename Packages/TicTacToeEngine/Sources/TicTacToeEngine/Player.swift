//
//  Player.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 26/01/2026.
//

enum PlayerType {
    case x, o
    
}

class Player {
    let type: PlayerType
    init(type: PlayerType) {
        self.type = type
    }
}
