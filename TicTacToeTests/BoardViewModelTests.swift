//
//  BoardViewModelTests.swift
//  TicTacToeTests
//
//  Created by 2026-DEV2-025 on 30/01/2026.
//

import XCTest
import TicTacToeEngine
@testable import TicTacToe

@MainActor
final class BoardViewModelTests: XCTestCase {
    func testBoardSetup() {
        let viewModel = BoardViewModel(boardSize: 3)

        XCTAssertEqual(viewModel.cells.count, 9)
        XCTAssertEqual(viewModel.currentStatus.text, Strings.Status.xTurn)
        XCTAssertEqual(viewModel.winningResult, WiningResult.none)
        XCTAssertNil(viewModel.winningCells)
        XCTAssertNil(viewModel.rulesResult)
    }

    func testTapCellUpdatesMarksAndStatus() {
        let viewModel = BoardViewModel(boardSize: 3)

        viewModel.tapCell(row: 0, column: 0)
        XCTAssertEqual(viewModel.cell(atRow: 0, column: 0)?.mark, .x)
        XCTAssertEqual(viewModel.currentStatus.text, Strings.Status.oTurn)

        viewModel.tapCell(row: 0, column: 1)
        XCTAssertEqual(viewModel.cell(atRow: 0, column: 1)?.mark, .o)
        XCTAssertEqual(viewModel.currentStatus.text, Strings.Status.xTurn)
    }

    func testTapCellRejectsAlreadyTakenCell() {
        let viewModel = BoardViewModel(boardSize: 3)

        viewModel.tapCell(row: 0, column: 0)
        viewModel.tapCell(row: 0, column: 0)

        XCTAssertEqual(viewModel.rulesResult, .cellIsAlreadyTakenError)
        XCTAssertEqual(viewModel.currentStatus.text, Strings.Status.cellAlreadyTaken)
        XCTAssertEqual(viewModel.cell(atRow: 0, column: 0)?.mark, .x)
        XCTAssertEqual(viewModel.winningResult, .none)
    }

    func testWinUpdatesWinningStateAndStatus() {
        let viewModel = BoardViewModel(boardSize: 3)

        viewModel.tapCell(row: 0, column: 0) // X
        viewModel.tapCell(row: 1, column: 0) // O
        viewModel.tapCell(row: 0, column: 1) // X
        viewModel.tapCell(row: 1, column: 1) // O
        viewModel.tapCell(row: 0, column: 2) // X wins

        XCTAssertEqual(viewModel.winningResult, .win)
        XCTAssertEqual(viewModel.currentStatus.text, Strings.Status.wins(Strings.Mark.x))
        XCTAssertEqual(viewModel.winningCells?.count, 3)
    }

    func testResetClearsState() {
        let viewModel = BoardViewModel(boardSize: 3)

        viewModel.tapCell(row: 0, column: 0)
        viewModel.tapCell(row: 1, column: 0)
        viewModel.reset()

        XCTAssertEqual(viewModel.currentStatus.text, Strings.Status.xTurn)
        XCTAssertEqual(viewModel.winningResult, .none)
        XCTAssertNil(viewModel.winningCells)
        XCTAssertNil(viewModel.rulesResult)
        XCTAssertTrue(viewModel.cells.allSatisfy { $0.mark == .none })
    }
}
