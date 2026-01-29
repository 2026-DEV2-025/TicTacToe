//
//  BoardStateTests.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 29/01/2026.
//

import XCTest
@testable import TicTacToeEngine

final class BoardStateTests: XCTestCase {
    
    func testGetAllCellsOnlyOneCellIsPlaced() {
        
        let cells: [BoardCell] = [
            .init(type: .x, toCell: .init(row: 0, column: 0)),
        ]
        
        let boardState = BoardStateImpl(moves: cells, boardSize: 3)
        let validationCells: [BoardCell] = [
            .init(type: .x, toCell: .init(row: 0, column: 0)),
            .init(type: .none, toCell: .init(row: 0, column: 1)),
            .init(type: .none, toCell: .init(row: 0, column: 2)),
            .init(type: .none, toCell: .init(row: 1, column: 0)),
            .init(type: .none, toCell: .init(row: 1, column: 1)),
            .init(type: .none, toCell: .init(row: 1, column: 2)),
            .init(type: .none, toCell: .init(row: 2, column: 0)),
            .init(type: .none, toCell: .init(row: 2, column: 1)),
            .init(type: .none, toCell: .init(row: 2, column: 2)),
        ]
        let allCells = boardState.getCells()
        
        boardState.prettyPrintCells()
        XCTAssertEqual(allCells.count, boardState.boardSize * boardState.boardSize)
        XCTAssertEqual(allCells, validationCells)
    }

    func testGetAllCellsForTypeReturnsOnlyXCells() {
        let moves: [BoardCell] = [
            .init(type: .x, toCell: .init(row: 0, column: 0)),
            .init(type: .o, toCell: .init(row: 0, column: 1)),
        ]
        let boardState = BoardStateImpl(moves: moves, boardSize: 2)

        let filteredCells = boardState.getCells(for: .x)
        let validationCells: [BoardCell] = [
            .init(type: .x, toCell: .init(row: 0, column: 0)),
            .init(type: .none, toCell: .init(row: 0, column: 1)),
            .init(type: .none, toCell: .init(row: 1, column: 0)),
            .init(type: .none, toCell: .init(row: 1, column: 1)),
        ]

        XCTAssertEqual(filteredCells, validationCells)
    }

    func testGetCellsWithNilTypeReturnsAllCells() {
        let moves: [BoardCell] = [
            .init(type: .x, toCell: .init(row: 0, column: 0)),
            .init(type: .o, toCell: .init(row: 0, column: 1)),
        ]
        let boardState = BoardStateImpl(moves: moves, boardSize: 2)

        let allCells = boardState.getCells(for: nil)
        let validationCells: [BoardCell] = [
            .init(type: .x, toCell: .init(row: 0, column: 0)),
            .init(type: .o, toCell: .init(row: 0, column: 1)),
            .init(type: .none, toCell: .init(row: 1, column: 0)),
            .init(type: .none, toCell: .init(row: 1, column: 1)),
        ]

        XCTAssertEqual(allCells, validationCells)
    }

    func testGetCellsForNoneReturnsAllNones() {
        let moves: [BoardCell] = [
            .init(type: .x, toCell: .init(row: 0, column: 0)),
            .init(type: .o, toCell: .init(row: 0, column: 1)),
        ]
        let boardState = BoardStateImpl(moves: moves, boardSize: 2)

        let emptyCells = boardState.getCells(for: CellMarkType.none)
        let validationCells: [BoardCell] = [
            .init(type: .none, toCell: .init(row: 0, column: 0)),
            .init(type: .none, toCell: .init(row: 0, column: 1)),
            .init(type: .none, toCell: .init(row: 1, column: 0)),
            .init(type: .none, toCell: .init(row: 1, column: 1)),
        ]

        XCTAssertEqual(emptyCells, validationCells)
    }

    func testBoardIsFullWhenAllCellsOccupied() {
        let moves: [BoardCell] = [
            .init(type: .x, toCell: .init(row: 0, column: 0)),
            .init(type: .o, toCell: .init(row: 0, column: 1)),
            .init(type: .x, toCell: .init(row: 1, column: 0)),
            .init(type: .o, toCell: .init(row: 1, column: 1)),
        ]
        let boardState = BoardStateImpl(moves: moves, boardSize: 2)

        XCTAssertTrue(boardState.boardIsFull())
    }
    
}
