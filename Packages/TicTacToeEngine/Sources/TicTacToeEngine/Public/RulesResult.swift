//
//  RulesResult.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 29/01/2026.
//

public enum RulesResult {
    case moveSucceeded
    case onlyXMustStartError
    case cellIsAlreadyTakenError
    case mustAlternateTurnsError
    case noMoreMovesAllowedError
    case unknownError
}
