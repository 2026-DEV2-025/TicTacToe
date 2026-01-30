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
    @Published private(set) var currentStatus: Status
    var onStatusUpdate: ((Status) -> Void)?

    private var nextMark: Mark = .x

    init(engine: TicTacToeEngine, boardSize: Int) {
        self.engine = engine
        self.boardSize = boardSize
        self.cells = engine.boardCells()
        self.currentStatus = Status(color: .primary, text: Strings.Status.xTurn)
        self.onStatusUpdate?(currentStatus)
    }
    
    deinit {
        //adding empty deinit because of pointer being freed was not allocated crash
        //well explained here: https://www.monkey.work/blog/2025-11-18-swift-ui-pointer-being-freed-was-not-allocated/
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
            currentStatus = Status(color: .red, text: Strings.Status.cellAlreadyTaken)
            onStatusUpdate?(currentStatus)
            return
        }

        let result = engine.makeMove(mark: nextMark, cell: cell)
        apply(result)

        if result.rulesResult == .moveSucceeded {
            toggleNextMark()
        }
        
        currentStatus = updateStatus(from: result)
        onStatusUpdate?(currentStatus)
    }

    func reset() {
        engine.reset()
        cells = engine.boardCells()
        winningCells = nil
        winningResult = .none
        rulesResult = nil
        nextMark = .x
        currentStatus = Status(color: .primary, text: Strings.Status.xTurn)
        onStatusUpdate?(currentStatus)
    }
    
    func updateStatus(from result: MovingResult) -> Status {
        func markText(_ mark: Mark) -> String {
            switch mark {
            case .x:
                return Strings.Mark.x
            case .o:
                return Strings.Mark.o
            case .none:
                return Strings.Mark.unknown
            }
        }

        switch result.winningResult {
        case .win:
            return .init(color: .green, text: Strings.Status.wins(markText(result.mark)))
        case .draw:
            return .init(color: .secondary, text: Strings.Status.draw)
        case .none:
            break
        }

        if let rulesResult = result.rulesResult {
            switch rulesResult {
            case .moveSucceeded:
                return .init(color: .primary, text: Strings.Status.turn(for: markText(nextMark)))
            case .onlyXMustStartError:
                return .init(color: .red, text: Strings.Status.onlyXMustStart)
            case .cellIsAlreadyTakenError:
                return .init(color: .red, text: Strings.Status.cellAlreadyTaken)
            case .mustAlternateTurnsError:
                return .init(color: .red, text: Strings.Status.mustAlternateTurns)
            case .noMoreMovesAllowedError:
                return .init(color: .red, text: Strings.Status.noMoreMoves)
            case .unknownError:
                return .init(color: .red, text: Strings.Status.unknownError)
            }
        }

        return .init(color: .primary, text: Strings.Status.turn(for: markText(nextMark)))
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
