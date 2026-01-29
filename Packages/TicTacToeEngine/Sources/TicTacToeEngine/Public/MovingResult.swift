//
//  MovingResult.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 29/01/2026.
//

public struct MovingResult {
    public let mark: Mark
    public let cells: [Cell]?
    public let rulesResult: RulesResult?
    public let winningResult: WiningResult

    public init(mark: Mark, cells: [Cell]?, rulesResult: RulesResult?, winningResult: WiningResult) {
        self.mark = mark
        self.cells = cells
        self.rulesResult = rulesResult
        self.winningResult = winningResult
    }
}
