//
//  TicTacToeEnginePublicTests.swift
//  TicTacToeEngineTests
//
//  Created by 2026-DEV2-025 on 29/01/2026.
//

import XCTest
import TicTacToeEngine

final class TicTacToeEnginePublicTests: XCTestCase {

    func testInitialBoardCellsOnDefaultBoard3x3() {
        let engine = TicTacToeEngine()
        let cells = engine.boardCells()
        XCTAssertEqual(cells.count, 9)
        XCTAssertEqual(cell(in: cells, row: 0, column: 0)?.mark, Mark.none)
        XCTAssertEqual(cell(in: cells, row: 2, column: 2)?.mark, Mark.none)
        //out of bounds
        XCTAssertNil(cell(in: cells, row: 4, column: 4)?.mark)
    }
    
    func testInitialBoardCellsOnDefaultBoard5x5() {
        let engine = TicTacToeEngine(boardSize: 5)
        let cells = engine.boardCells()
        XCTAssertEqual(cells.count, 25)
        XCTAssertEqual(cell(in: cells, row: 0, column: 0)?.mark, Mark.none)
        XCTAssertEqual(cell(in: cells, row: 2, column: 2)?.mark, Mark.none)
        //out of bounds
        XCTAssertNil(cell(in: cells, row: 7, column: 7)?.mark)
    }


    func testMakeUserMoveAndCheckCells() {
        let engine = TicTacToeEngine()

        let result = engine.makeMove(mark: .x, cell: Cell(row: 0, column: 2))
        XCTAssertEqual(result.rulesResult, .moveSucceeded)
        XCTAssertEqual(result.winningResult, .none)
        XCTAssertEqual(result.mark, .none)
        XCTAssertNil(result.cells)

        let cells = engine.boardCells()
        XCTAssertEqual(cell(in: cells, row: 0, column: 2)?.mark, .x)
    }

    func testFirstMoveMustBeX() {
        let engine = TicTacToeEngine()

        let result = engine.makeMove(mark: .o, cell: Cell(row: 1, column: 1))
        XCTAssertEqual(result.rulesResult, .onlyXMustStartError)
        XCTAssertEqual(result.winningResult, .none)
        XCTAssertEqual(result.mark, .o)

        let cells = engine.boardCells()
        XCTAssertEqual(cell(in: cells, row: 1, column: 1)?.mark, Mark.none)
    }

    func testWinningMoveReturnsWinningResultAndCells() {
        let engine = TicTacToeEngine()

        engine.makeMove(mark: .x, cell: Cell(row: 0, column: 0))
        engine.makeMove(mark: .o, cell: Cell(row: 1, column: 0))
        engine.makeMove(mark: .x, cell: Cell(row: 0, column: 1))
        engine.makeMove(mark: .o, cell: Cell(row: 1, column: 1))

        let result = engine.makeMove(mark: .x, cell: Cell(row: 0, column: 2))

        XCTAssertEqual(result.winningResult, .win)
        XCTAssertEqual(result.rulesResult, .moveSucceeded)
        XCTAssertEqual(result.mark, .x)
        XCTAssertEqual(result.cells, [
            Cell(row: 0, column: 0),
            Cell(row: 0, column: 1),
            Cell(row: 0, column: 2)
        ])
    }
    
    func testWinningColumnInTheCenter() {
        let engine = TicTacToeEngine()

        engine.makeMove(mark: .x, cell: Cell(row: 0, column: 1))
        engine.makeMove(mark: .o, cell: Cell(row: 1, column: 0))
        engine.makeMove(mark: .x, cell: Cell(row: 1, column: 1))
        engine.makeMove(mark: .o, cell: Cell(row: 1, column: 2))

        let result = engine.makeMove(mark: .x, cell: Cell(row: 2, column: 1))

        XCTAssertEqual(result.winningResult, .win)
        XCTAssertEqual(result.rulesResult, .moveSucceeded)
        XCTAssertEqual(result.mark, .x)
        XCTAssertEqual(result.cells, [
            Cell(row: 0, column: 1),
            Cell(row: 1, column: 1),
            Cell(row: 2, column: 1)
        ])
    }


    func testDrawResultOnFinalMove() {
        let engine = TicTacToeEngine()

        engine.makeMove(mark: .x, cell: Cell(row: 0, column: 0))
        engine.makeMove(mark: .o, cell: Cell(row: 0, column: 1))
        engine.makeMove(mark: .x, cell: Cell(row: 0, column: 2))
        engine.makeMove(mark: .o, cell: Cell(row: 1, column: 1))
        engine.makeMove(mark: .x, cell: Cell(row: 1, column: 0))
        engine.makeMove(mark: .o, cell: Cell(row: 1, column: 2))
        engine.makeMove(mark: .x, cell: Cell(row: 2, column: 1))
        engine.makeMove(mark: .o, cell: Cell(row: 2, column: 0))

        let result = engine.makeMove(mark: .x, cell: Cell(row: 2, column: 2))

        XCTAssertEqual(result.winningResult, .draw)
        XCTAssertEqual(result.rulesResult, .noMoreMovesAllowedError)
        XCTAssertEqual(result.mark, .none)
        XCTAssertNil(result.cells)
    }

    func testResetClearsBoardState() {
        let engine = TicTacToeEngine()
        engine.makeMove(mark: .x, cell: Cell(row: 0, column: 0))
        engine.reset()

        let cells = engine.boardCells()
        XCTAssertEqual(cells.count, 9)
        XCTAssertEqual(cell(in: cells, row: 0, column: 0)?.mark, Mark.none)
    }

    func testCurrentMarkReturnsLastPlayedCell() {
        let engine = TicTacToeEngine()
        XCTAssertNil(engine.currentMark())

        engine.makeMove(mark: .x, cell: Cell(row: 2, column: 1))
        let current = engine.currentMark()

        XCTAssertEqual(current?.row, 2)
        XCTAssertEqual(current?.column, 1)
        XCTAssertEqual(current?.mark, .x)
    }

    func testEmptyCellsInitialAndAfterMoves() {
        let engine = TicTacToeEngine()
        XCTAssertEqual(engine.emptyCells().count, 9)

        engine.makeMove(mark: .x, cell: Cell(row: 0, column: 0))
        engine.makeMove(mark: .o, cell: Cell(row: 1, column: 1))

        let emptyCells = engine.emptyCells()
        XCTAssertEqual(emptyCells.count, 7)
        XCTAssertNil(cell(in: emptyCells, row: 0, column: 0))
        XCTAssertNil(cell(in: emptyCells, row: 1, column: 1))
        XCTAssertEqual(cell(in: emptyCells, row: 2, column: 2)?.mark, Mark.none)
    }

    func testIsCellAvailable() {
        let engine = TicTacToeEngine()
        XCTAssertTrue(engine.isCellAvailable(Cell(row: 0, column: 0)))
        engine.makeMove(mark: .x, cell: Cell(row: 0, column: 0))
        XCTAssertFalse(engine.isCellAvailable(Cell(row: 0, column: 0)))
        XCTAssertTrue(engine.isCellAvailable(Cell(row: 0, column: 1)))
    }
}

private func cell(in cells: [Cell], row: Int, column: Int) -> Cell? {
    cells.first { $0.row == row && $0.column == column }
}
