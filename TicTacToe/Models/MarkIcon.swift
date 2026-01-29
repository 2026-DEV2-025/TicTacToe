//
//  MarkIcon.swift
//  TicTacToe
//
//  Created by 2026-DEV2-025 on 29/01/2026.
//

import TicTacToeEngine

enum MarkIcon: String, Equatable {
    case x = "xmark", o = "circle", none = ""
}

extension Mark {
    var asMarkIcon: MarkIcon {
        switch self {
        case .none:
            return .none
        case .x:
            return .x
        case .o:
            return .o
        }
    }
}
