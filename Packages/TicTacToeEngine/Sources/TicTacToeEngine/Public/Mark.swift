//
//  MarkType.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 29/01/2026.
//

public enum Mark {
    case x, o, none
}

internal extension Mark {
    var asPlayerType: PlayerType {
        switch self {
        case .x:
            return .x
        case .o:
            return .o
        case .none:
            return .none
        }
    }
}
