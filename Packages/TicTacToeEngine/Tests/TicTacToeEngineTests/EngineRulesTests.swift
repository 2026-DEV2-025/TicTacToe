//
//  EngineRulesTests.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 26/01/2026.
//

//Rules provided from the public repo: https://github.com/stephane-genicot/katas/blob/master/TicTacToe.md

import XCTest
@testable import TicTacToeEngine

final class EngineRulesTests: XCTestCase {    
    
    //MARK: - X always goes first tests
    
    func testXGoesFirst() throws {
        let board = Board(cells: [])
        let boardState = BoardStateMock(moves: [], board: board)
        let rulesProtocol = EngineRulesImpl(boardState: boardState)
        let engine = EngineImpl(boardState: boardState, engineRules: rulesProtocol)
        let playerX = Player(type: .x)
        let cell = BoardCell(row: 0, column: 0)
        let move = PlayerMove(player: playerX, toCell: cell)
        XCTAssertEqual(engine.playerMove(move: move) == .moveSucceeded)
    }
    
    func testOGoesFirst() throws {
        let board = Board(cells: [])
        let boardState = BoardStateMock(moves: [], board: board)
        let rulesProtocol = EngineRulesImpl(boardState: boardState)
        let engine = EngineImpl(boardState: boardState, engineRules: rulesProtocol)
        let playerO = Player(type: .o)
        let cell = BoardCell(row: 0, column: 0)
        let move = PlayerMove(player: playerO, toCell: cell)
        XCTAssertEqual(engine.playerMove(move: move) == .onlyXMustStartError)
    }
}

