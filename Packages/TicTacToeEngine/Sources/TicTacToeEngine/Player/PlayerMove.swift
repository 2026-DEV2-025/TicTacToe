//
//  PlayerMove.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 26/01/2026.
//

struct PlayerMove {
    let player: Player
    let cell: BoardCell
    
    init(player: Player, toCell cell: BoardCell) {
        self.player = player
        self.cell = cell
    }
}
