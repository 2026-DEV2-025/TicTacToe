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
        let boardState = BoardStateMock(moves: [])
        let engineRules = EngineRulesImpl(boardState: boardState)
        let moveByX = PlayerMove(player: .init(type: .x), toCell: .init(row: 0, column: 0))
        
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByX), .moveSucceeded)
    }
    
    func testOGoesFirst() throws {
        let boardState = BoardStateMock(moves: [])
        let engineRules = EngineRulesImpl(boardState: boardState)
        let moveByO = PlayerMove(player: .init(type: .o), toCell: .init(row: 0, column: 0))
        
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByO), .onlyXMustStartError)
    }

    func testOCanMoveAfterFirstMove() throws {
        let firstMoveByX = PlayerMove(player: .init(type: .x), toCell: .init(row: 0, column: 0))
        let boardState = BoardStateMock(moves: [firstMoveByX])
        let engineRules = EngineRulesImpl(boardState: boardState)
        let moveByO = PlayerMove(player: .init(type: .o), toCell: .init(row: 0, column: 1))
        
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByO), .moveSucceeded)
    }
}
