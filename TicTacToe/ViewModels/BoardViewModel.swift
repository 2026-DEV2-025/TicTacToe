//
//  BoardViewModel.swift
//  TicTacToe
//
//  Created by 2026-DEV2-025 on 29/01/2026.
//

import Combine
import SwiftUI
import TicTacToeEngine

@MainActor
final class BoardViewModel: ObservableObject {
    let engine: TicTacToeEngine
    let boardSize: Int

    @Published private(set) var cells: [Cell]
    @Published private(set) var winningCells: [Cell]?
    @Published private(set) var winningResult: WiningResult = .none
    @Published private(set) var rulesResult: RulesResult?

    private var nextMark: Mark = .x

    init(engine: TicTacToeEngine, boardSize: Int) {
        self.engine = engine
        self.boardSize = boardSize
        self.cells = engine.boardCells()
    }

    convenience init(boardSize: Int = 3) {
        self.init(engine: TicTacToeEngine(boardSize: boardSize), boardSize: boardSize)
    }

    func cell(atRow row: Int, column: Int) -> Cell? {
        let index = row * boardSize + column
        guard index >= 0, index < cells.count else {
            return nil
        }
        return cells[index]
    }

    func tapCell(row: Int, column: Int) {
        guard winningResult == .none else {
            return
        }

        let cell = Cell(row: row, column: column)
        guard engine.isCellAvailable(cell) else {
            rulesResult = .cellIsAlreadyTakenError
            return
        }

        let result = engine.makeMove(mark: nextMark, cell: cell)
        apply(result)

        if result.rulesResult == .moveSucceeded {
            toggleNextMark()
        }
    }

    func reset() {
        engine.reset()
        cells = engine.boardCells()
        winningCells = nil
        winningResult = .none
        rulesResult = nil
        nextMark = .x
    }
}

private extension BoardViewModel {
    func apply(_ result: MovingResult) {
        cells = engine.boardCells()
        winningCells = result.cells
        winningResult = result.winningResult
        rulesResult = result.rulesResult
    }

    func toggleNextMark() {
        nextMark = (nextMark == .x) ? .o : .x
    }
}
