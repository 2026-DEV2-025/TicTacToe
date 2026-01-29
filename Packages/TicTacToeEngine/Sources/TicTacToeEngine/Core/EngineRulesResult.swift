//
//  EngineRulesResult.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 26/01/2026.
//

enum EngineRulesResult {
    case draw
    case moveSucceeded
    case winning
    case onlyXMustStartError
    case cellIsAlreadyTakenError
    case mustAlternateTurnsError
    case noMoreMovesAllowedError
    case unknownError
}
