//
//  CellMarkType.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 26/01/2026.
//

enum CellMarkType {
    case x, o, none
    
    var asMark: Mark {
        switch self {
        case .x: return .x
        case .o: return .o
        case .none: return .none
        }
    }
}
