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
        let boardState = BoardStateImpl(moves: [])
        let engineRules = EngineRulesImpl(boardState: boardState)
        let moveByX = PlayerMove(player: .init(type: .x), toCell: .init(row: 0, column: 0))
        
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByX), .moveSucceeded)
    }
    
    func testOGoesFirst() throws {
        let boardState = BoardStateImpl(moves: [])
        let engineRules = EngineRulesImpl(boardState: boardState)
        let moveByO = PlayerMove(player: .init(type: .o), toCell: .init(row: 0, column: 0))
        
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByO), .onlyXMustStartError)
    }

    func testOCanMoveAfterFirstMove() throws {
        let firstMoveByX = PlayerMove(player: .init(type: .x), toCell: .init(row: 0, column: 0))
        let boardState = BoardStateImpl(moves: [firstMoveByX])
        let engineRules = EngineRulesImpl(boardState: boardState)
        let moveByO = PlayerMove(player: .init(type: .o), toCell: .init(row: 0, column: 1))
        
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByO), .moveSucceeded)
    }
    
    //MARK: - Players cannot play on a played position tests
    
    func testPlayOnTakenPosition() throws {
        let cell = BoardCell(row: 0, column: 0)

        let moveByX = PlayerMove(player: .init(type: .x), toCell: cell)
        let boardState = BoardStateImpl(moves: [moveByX])
        let engineRules = EngineRulesImpl(boardState: boardState)
        
        let moveByO = PlayerMove(player: .init(type: .o), toCell: cell)
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByO), .cellIsAlreadyTakenError)
    }
    
    func testPlayOnTakenPositionBySamePlayer() throws {
        let cell = BoardCell(row: 0, column: 0)

        let moveByX = PlayerMove(player: .init(type: .x), toCell: cell)
        let boardState = BoardStateImpl(moves: [moveByX])
        let engineRules = EngineRulesImpl(boardState: boardState)
        
        let secondMoveByX = PlayerMove(player: .init(type: .x), toCell: cell)
        XCTAssertEqual(engineRules.checkMoveIsValid(move: secondMoveByX), .cellIsAlreadyTakenError)
    }
    
    func testPlayOnTakenPositionWithMultipleMovesOnBoard() throws {
        let occupiedCell = BoardCell(row: 0, column: 0)
        let otherCell = BoardCell(row: 0, column: 1)

        let moveByX = PlayerMove(player: .init(type: .x), toCell: occupiedCell)
        let moveByO = PlayerMove(player: .init(type: .o), toCell: otherCell)
        let boardState = BoardStateImpl(moves: [moveByX, moveByO])
        let engineRules = EngineRulesImpl(boardState: boardState)
        
        let moveByXOnTakenCell = PlayerMove(player: .init(type: .x), toCell: occupiedCell)
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByXOnTakenCell), .cellIsAlreadyTakenError)
    }
    
    func testPlayOnDifferentEmptyCellAfterMove() throws {
        let takenCell = BoardCell(row: 0, column: 0)
        let emptyCell = BoardCell(row: 0, column: 1)

        let moveByX = PlayerMove(player: .init(type: .x), toCell: takenCell)
        let boardState = BoardStateImpl(moves: [moveByX])
        let engineRules = EngineRulesImpl(boardState: boardState)
        
        let moveByO = PlayerMove(player: .init(type: .o), toCell: emptyCell)
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByO), .moveSucceeded)
    }
    
    //MARK: Alternating moves by players tests
    
    func testPlayersAlternatingEachOtherFullBoard() throws {
        let boardSize = 3
        let boardState = BoardStateImpl(moves: [])
        let engineRules = EngineRulesImpl(boardState: boardState)
        var alt = true
        for i in 0..<boardSize {
            for j in 0..<boardSize {
                let moveBy = PlayerMove(player: .init(type: alt ? .x : .o), toCell: .init(row: i, column: j))
                XCTAssertEqual(engineRules.checkMoveIsValid(move: moveBy), .moveSucceeded)
                boardState.addMove(moveBy)
                alt = !alt
            }
        }
    }

    func testAlternatingPlayersWithSameTypeX() throws {
        let boardSize = 3
        let firstMove = PlayerMove(player: .init(type: .x), toCell: .init(row: 0, column: 0))
        let boardState = BoardStateImpl(moves: [firstMove])
        let engineRules = EngineRulesImpl(boardState: boardState)
        for i in 1..<boardSize {
            for j in 0..<boardSize {
                let moveBy = PlayerMove(player: .init(type: .x), toCell: .init(row: i, column: j))
                XCTAssertEqual(engineRules.checkMoveIsValid(move: moveBy), .mustAlternateTurnsError)
                boardState.addMove(moveBy)
            }
        }
    }
    
    func testAlternatingPlayersWithSameTypeO() throws {
        let boardSize = 3
        let firstMove = PlayerMove(player: .init(type: .o), toCell: .init(row: 0, column: 0))
        let boardState = BoardStateImpl(moves: [firstMove])
        let engineRules = EngineRulesImpl(boardState: boardState)
        var alt = true
        for i in 0..<boardSize {
            for j in 0..<boardSize {
                let moveBy = PlayerMove(player: .init(type: alt ? .x : .o), toCell: .init(row: i, column: j))
                XCTAssertEqual(engineRules.checkMoveIsValid(move: moveBy), .moveSucceeded)
                boardState.addMove(moveBy)
                alt = !alt
            }
        }
    }
    
    //MARK: - Finishing the game
    
    func testPlayerHasThreeInARow() throws {
        let boardSize = 3
        let boardState = BoardStateImpl(moves: [])
        let engineRules = EngineRulesImpl(boardState: boardState)
        let engine = Engine(boardState: boardState, engineRules: engineRules)
        var validationWinnerCells = [BoardCell]()
        for i in 0..<boardSize {
            let moveBy = PlayerMove(
                player: .init(type: .x),
                toCell: .init(row: i, column: 0)
            )
            boardState.addMove(moveBy)
            validationWinnerCells.append(moveBy.cell)
        }
        let lastPlayed = boardState.moves.last!
        let winner = engine.checkWinner(for: lastPlayed.player.type)
        XCTAssertNotNil(winner)
        XCTAssertEqual(winner.type, .x)
        XCTAssertEqual(winner.cells, validationWinnerCells)
        XCTAssertEqual(winner.rulesResult, .moveSucceeded)
    }
    
    func testPlayerHasThreeInAColumn() throws {
        let boardSize = 3
        let boardState = BoardStateImpl(moves: [])
        let engineRules = EngineRulesImpl(boardState: boardState)
        let engine = Engine(boardState: boardState, engineRules: engineRules)
        var validationWinnerCells = [BoardCell]()
        for j in 0..<boardSize {
            let moveBy = PlayerMove(
                player: .init(type: .x),
                toCell: .init(row: 0, column: j)
            )
            boardState.addMove(moveBy)
            validationWinnerCells.append(moveBy.cell)
        }
        
        let lastPlayed = boardState.moves.last!
        let winner = engine.checkWinner(for: lastPlayed.player.type)
        XCTAssertNotNil(winner)
        XCTAssertEqual(winner.type, .x)
        XCTAssertEqual(winner.cells, validationWinnerCells)
        XCTAssertEqual(winner.rulesResult, .moveSucceeded)
    }
    
    func testPlayerHasThreeInADiagonal() throws {
        let boardSize = 3
        let boardState = BoardStateImpl(moves: [])
        let engineRules = EngineRulesImpl(boardState: boardState)
        let engine = Engine(boardState: boardState, engineRules: engineRules)
        var validationWinnerCells = [BoardCell]()
        for j in 0..<boardSize {
            let moveBy = PlayerMove(
                player: .init(type: .x),
                toCell: .init(row: j, column: j)
            )
            boardState.addMove(moveBy)
            validationWinnerCells.append(moveBy.cell)
        }
        
        let lastPlayed = boardState.moves.last!
        let winner = engine.checkWinner(for: lastPlayed.player.type)
        XCTAssertNotNil(winner)
        XCTAssertEqual(winner.type, .x)
        XCTAssertEqual(winner.cells, validationWinnerCells)
        XCTAssertEqual(winner.rulesResult, .moveSucceeded)
    }
    
    func testAllCellsAreFilledAndDrawHappen() throws {
        let move1 = PlayerMove(player: .init(type: .x), toCell: .init(row: 0, column: 0))
        let move2 = PlayerMove(player: .init(type: .x), toCell: .init(row: 0, column: 1))
        let move3 = PlayerMove(player: .init(type: .o), toCell: .init(row: 0, column: 2))
        let movesTmp = [move1, move2, move3]
        let moves = movesTmp + movesTmp.reversed() + movesTmp
        let boardState = BoardStateImpl(moves: moves)
        let engineRules = EngineRulesImpl(boardState: boardState)
        let engine = Engine(boardState: boardState, engineRules: engineRules)

        let lastPlayed = boardState.moves.last!
        let winner = engine.checkWinner(for: lastPlayed.player.type)
        XCTAssertNotNil(winner)
        XCTAssertEqual(winner.type, .none)
        XCTAssertNil(winner.cells)
        XCTAssertEqual(winner.rulesResult, .moveSucceeded)
    }
    
    func testBoardIsFull() throws {
        let boardSize = 3
        let boardState = BoardStateImpl(moves: [])
        let engineRules = EngineRulesImpl(boardState: boardState)
        
        var alt = true
        for i in 0..<boardSize {
            for j in 0..<boardSize {
                let moveBy = PlayerMove(
                    player: .init(
                        type: alt ? .x : .o
                    ),
                    toCell: .init(row: i, column: j)
                )
                boardState.addMove(moveBy)
                alt = !alt
            }
        }
        
        let anotherMove = PlayerMove(player: .init(type: .o), toCell: .init(row: 3, column: 3))
        XCTAssertEqual(engineRules.checkMoveIsValid(move: anotherMove), .noMoreMovesAllowedError)
    }
    
    func testAllCellsAreFilledAndXPlayerHasWon() throws {
        let boardSize = 3
        let boardState = BoardStateImpl(moves: [])
        let engineRules = EngineRulesImpl(boardState: boardState)
        let engine = Engine(boardState: boardState, engineRules: engineRules)
        var validationWinnerCells = [BoardCell]()
        var alt = true
        for i in 0..<boardSize {
            for j in 0..<boardSize {
                let moveBy = PlayerMove(player: .init(type: alt ? .x : .o), toCell: .init(row: i, column: j))
                boardState.addMove(moveBy)
                alt = !alt
            }
        }
        validationWinnerCells = [
            .init(row: 0, column: 0),
            .init(row: 1, column: 1),
            .init(row: 2, column: 2),
        ]
        
        let nextMove = PlayerMove(player: .init(type: .o), toCell: .init(row: 3, column: 3))
        
        let winner = engine.makeMove(by: nextMove)
        XCTAssertNotNil(winner)
        XCTAssertEqual(winner.type, .x)
        XCTAssertEqual(winner.cells, validationWinnerCells)
        XCTAssertEqual(winner.rulesResult, .moveSucceeded)
    }

    func testAllCellsAreFilledAndOPlayerHasWon() throws {
        let boardSize = 3
        let boardState = BoardStateImpl(moves: [])
        let engineRules = EngineRulesImpl(boardState: boardState)
        let engine = Engine(boardState: boardState, engineRules: engineRules)
        var validationWinnerCells = [BoardCell]()
        var alt = false
        for i in 0..<boardSize {
            for j in 0..<boardSize {
                let moveBy = PlayerMove(player: .init(type: alt ? .x : .o), toCell: .init(row: i, column: j))
                boardState.addMove(moveBy)
                alt = !alt
            }
        }
        
        validationWinnerCells = [
            .init(row: 0, column: 0),
            .init(row: 1, column: 1),
            .init(row: 2, column: 2),
        ]
        
        let nextMove = PlayerMove(player: .init(type: .x), toCell: .init(row: 3, column: 3))
        
        let winner = engine.makeMove(by: nextMove)
        XCTAssertNotNil(winner)
        XCTAssertEqual(winner.type, .o)
        XCTAssertEqual(winner.cells, validationWinnerCells)
        XCTAssertEqual(winner.rulesResult, .moveSucceeded)
    }

    
}
