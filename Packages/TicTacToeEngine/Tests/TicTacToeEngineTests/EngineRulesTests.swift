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
    
    //MARK: - Players cannot play on a played position tests
    
    func testPlayOnTakenPosition() throws {
        let cell = BoardCell(row: 0, column: 0)

        let moveByX = PlayerMove(player: .init(type: .x), toCell: cell)
        let boardState = BoardStateMock(moves: [moveByX])
        let engineRules = EngineRulesImpl(boardState: boardState)
        
        let moveByO = PlayerMove(player: .init(type: .o), toCell: cell)
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByO), .cellIsAlreadyTakenError)
    }
    
    func testPlayOnTakenPositionBySamePlayer() throws {
        let cell = BoardCell(row: 0, column: 0)

        let moveByX = PlayerMove(player: .init(type: .x), toCell: cell)
        let boardState = BoardStateMock(moves: [moveByX])
        let engineRules = EngineRulesImpl(boardState: boardState)
        
        let secondMoveByX = PlayerMove(player: .init(type: .x), toCell: cell)
        XCTAssertEqual(engineRules.checkMoveIsValid(move: secondMoveByX), .cellIsAlreadyTakenError)
    }
    
    func testPlayOnTakenPositionWithMultipleMovesOnBoard() throws {
        let occupiedCell = BoardCell(row: 0, column: 0)
        let otherCell = BoardCell(row: 0, column: 1)

        let moveByX = PlayerMove(player: .init(type: .x), toCell: occupiedCell)
        let moveByO = PlayerMove(player: .init(type: .o), toCell: otherCell)
        let boardState = BoardStateMock(moves: [moveByX, moveByO])
        let engineRules = EngineRulesImpl(boardState: boardState)
        
        let moveByXOnTakenCell = PlayerMove(player: .init(type: .x), toCell: occupiedCell)
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByXOnTakenCell), .cellIsAlreadyTakenError)
    }
    
    func testPlayOnDifferentEmptyCellAfterMove() throws {
        let takenCell = BoardCell(row: 0, column: 0)
        let emptyCell = BoardCell(row: 0, column: 1)

        let moveByX = PlayerMove(player: .init(type: .x), toCell: takenCell)
        let boardState = BoardStateMock(moves: [moveByX])
        let engineRules = EngineRulesImpl(boardState: boardState)
        
        let moveByO = PlayerMove(player: .init(type: .o), toCell: emptyCell)
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByO), .moveSucceeded)
    }
    
    //MARK: Alternating moves by players tests
    
    func testPlayersAlternatingEachOtherFullBoard() throws {
        let boardSize = 3
        let boardState = BoardStateMock(moves: [])
        let engineRules = EngineRulesImpl(boardState: boardState)
        var alt = true
        for i in 0..<boardSize {
            for j in 0..<boardSize {
                let moveBy = PlayerMove(player: .init(type: alt ? .x : .o), toCell: .init(row: i, column: j))
                XCTAssertEqual(engineRules.checkMoveIsValid(move: moveBy), .moveSucceeded)
                boardState.moves.append(moveBy)
                alt = !alt
            }
        }
    }

    func testAlternatingPlayersWithSameTypeX() throws {
        let boardSize = 3
        let firstMove = PlayerMove(player: .init(type: .x), toCell: .init(row: 0, column: 0))
        let boardState = BoardStateMock(moves: [firstMove])
        let engineRules = EngineRulesImpl(boardState: boardState)
        for i in 1..<boardSize {
            for j in 0..<boardSize {
                let moveBy = PlayerMove(player: .init(type: .x), toCell: .init(row: i, column: j))
                XCTAssertEqual(engineRules.checkMoveIsValid(move: moveBy), .mustAlternateTurnsError)
                boardState.moves.append(moveBy)
            }
        }
    }
    
    func testAlternatingPlayersWithSameTypeO() throws {
        let boardSize = 3
        let firstMove = PlayerMove(player: .init(type: .o), toCell: .init(row: 0, column: 0))
        let boardState = BoardStateMock(moves: [firstMove])
        let engineRules = EngineRulesImpl(boardState: boardState)
        for i in 1..<boardSize {
            for j in 0..<boardSize {
                let moveBy = PlayerMove(player: .init(type: .o), toCell: .init(row: i, column: j))
                XCTAssertEqual(engineRules.checkMoveIsValid(move: moveBy), .mustAlternateTurnsError)
                boardState.moves.append(moveBy)
            }
        }
    }


}
