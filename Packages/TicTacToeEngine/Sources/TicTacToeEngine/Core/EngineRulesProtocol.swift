//
//  EngineRulesProtocol.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 30/01/2026.
//

protocol EngineRules {
    func checkMoveIsValid(move: BoardCell) -> EngineRulesResult
}
