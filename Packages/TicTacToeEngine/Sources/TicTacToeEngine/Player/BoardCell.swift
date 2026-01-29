//
//  BoardCell.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 26/01/2026.
//

struct BoardCell: Equatable {
    let type: CellMarkType
    let cell: CellCoordinate
    
    init(type: CellMarkType, toCell cell: CellCoordinate) {
        self.type = type
        self.cell = cell
    }    
}
