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
        let boardState = BoardStateImpl(moves: [], boardSize: 3)
        let engineRules = EngineRulesImpl(boardState: boardState)
        let moveByX = BoardCell(type: .x, toCell: .init(row: 0, column: 0))
        
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByX), .moveSucceeded)
    }
    
    func testOGoesFirst() throws {
        let boardState = BoardStateImpl(moves: [], boardSize: 3)
        let engineRules = EngineRulesImpl(boardState: boardState)
        let moveByO = BoardCell(type: .o, toCell: .init(row: 0, column: 0))
        
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByO), .onlyXMustStartError)
    }
    
    func testOCanMoveAfterFirstMove() throws {
        let firstMoveByX = BoardCell(type: .x, toCell: .init(row: 0, column: 0))
        let boardState = BoardStateImpl(moves: [firstMoveByX], boardSize: 3)
        let engineRules = EngineRulesImpl(boardState: boardState)
        let moveByO = BoardCell(type: .o, toCell: .init(row: 0, column: 1))
        
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByO), .moveSucceeded)
    }
    
    //MARK: - Players cannot play on a played position tests
    
    func testPlayOnTakenPosition() throws {
        let cell = CellCoordinate(row: 0, column: 0)
        
        let moveByX = BoardCell(type: .x, toCell: cell)
        let boardState = BoardStateImpl(moves: [moveByX], boardSize: 3)
        let engineRules = EngineRulesImpl(boardState: boardState)
        
        let moveByO = BoardCell(type: .o, toCell: cell)
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByO), .cellIsAlreadyTakenError)
    }
    
    func testPlayOnTakenPositionBySamePlayer() throws {
        let cell = CellCoordinate(row: 0, column: 0)
        
        let moveByX = BoardCell(type: .x, toCell: cell)
        let boardState = BoardStateImpl(moves: [moveByX], boardSize: 3)
        let engineRules = EngineRulesImpl(boardState: boardState)
        
        let secondMoveByX = BoardCell(type: .x, toCell: cell)
        XCTAssertEqual(engineRules.checkMoveIsValid(move: secondMoveByX), .cellIsAlreadyTakenError)
    }
    
    func testPlayOnTakenPositionWithMultipleMovesOnBoard() throws {
        let occupiedCell = CellCoordinate(row: 0, column: 0)
        let otherCell = CellCoordinate(row: 0, column: 1)
        
        let moveByX = BoardCell(type: .x, toCell: occupiedCell)
        let moveByO = BoardCell(type: .o, toCell: otherCell)
        let boardState = BoardStateImpl(moves: [moveByX, moveByO], boardSize: 3)
        let engineRules = EngineRulesImpl(boardState: boardState)
        
        let moveByXOnTakenCell = BoardCell(type: .x, toCell: occupiedCell)
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByXOnTakenCell), .cellIsAlreadyTakenError)
    }
    
    func testPlayOnDifferentEmptyCellAfterMove() throws {
        let takenCell = CellCoordinate(row: 0, column: 0)
        let emptyCell = CellCoordinate(row: 0, column: 1)
        
        let moveByX = BoardCell(type: .x, toCell: takenCell)
        let boardState = BoardStateImpl(moves: [moveByX], boardSize: 3)
        let engineRules = EngineRulesImpl(boardState: boardState)
        
        let moveByO = BoardCell(type: .o, toCell: emptyCell)
        XCTAssertEqual(engineRules.checkMoveIsValid(move: moveByO), .moveSucceeded)
    }
    
    //MARK: - Alternating moves by players tests
    
    func testPlayersAlternatingEachOtherFullBoard() throws {
        let boardState = BoardStateImpl(moves: [], boardSize: 3)
        let engineRules = EngineRulesImpl(boardState: boardState)
        var alt = true
        for i in 0..<boardState.boardSize {
            for j in 0..<boardState.boardSize {
                let moveBy = BoardCell(type: alt ? .x : .o, toCell: .init(row: i, column: j))
                XCTAssertEqual(engineRules.checkMoveIsValid(move: moveBy), .moveSucceeded)
                boardState.addMove(moveBy)
                alt = !alt
            }
        }
    }
    
    func testAlternatingPlayersWithSameTypeX() throws {
        let firstMove = BoardCell(type: .x, toCell: .init(row: 0, column: 0))
        let boardState = BoardStateImpl(moves: [firstMove], boardSize: 3)
        let engineRules = EngineRulesImpl(boardState: boardState)
        for i in 1..<boardState.boardSize {
            for j in 0..<boardState.boardSize {
                let moveBy = BoardCell(type: .x, toCell: .init(row: i, column: j))
                XCTAssertEqual(engineRules.checkMoveIsValid(move: moveBy), .mustAlternateTurnsError)
                boardState.addMove(moveBy)
            }
        }
    }
    
    func testAlternatingPlayersWithSameTypeO() throws {
        let firstMove = BoardCell(type: .o, toCell: .init(row: 0, column: 0))
        let boardState = BoardStateImpl(moves: [firstMove], boardSize: 3)
        let engineRules = EngineRulesImpl(boardState: boardState)
        var alt = true
        for i in 0..<boardState.boardSize {
            for j in 0..<boardState.boardSize {
                if i == 0 && j == 0 {
                    //skipping here, otherwise we will get already taken error
                    continue
                }
                let moveBy = BoardCell(type: alt ? .x : .o, toCell: .init(row: i, column: j))
                XCTAssertEqual(engineRules.checkMoveIsValid(move: moveBy), .moveSucceeded)
                boardState.addMove(moveBy)
                alt = !alt
            }
        }
    }
    
    //MARK: - Finishing the game
    
    func testPlayerHasThreeInARow() throws {
        let boardState = BoardStateImpl(moves: [], boardSize: 3)
        let engineRules = EngineRulesImpl(boardState: boardState)
        let engine = Engine(boardState: boardState, engineRules: engineRules)
        var validationWinnerCells = [CellCoordinate]()
        for i in 0..<boardState.boardSize {
            let moveBy = BoardCell(
                type: .x,
                toCell: .init(row: 0, column: i)
            )
            boardState.addMove(moveBy)
            validationWinnerCells.append(moveBy.cell)
        }
        let lastPlayed = boardState.moves.last!
        let winner = engine.checkWinner(for: lastPlayed.type)
        XCTAssertNotNil(winner)
        XCTAssertEqual(winner?.winningMark, .x)
        XCTAssertEqual(winner?.winningCells, validationWinnerCells)
        XCTAssertEqual(winner?.rulesResult, .winning)
    }
    
    func testPlayerHasThreeInAColumn() throws {
        let boardState = BoardStateImpl(moves: [], boardSize: 3)
        let engineRules = EngineRulesImpl(boardState: boardState)
        let engine = Engine(boardState: boardState, engineRules: engineRules)
        var validationWinnerCells = [CellCoordinate?]()
        for j in 0..<boardState.boardSize {
            let moveBy = BoardCell(type: .x, toCell: .init(row: j, column: 0))
            boardState.addMove(moveBy)
            validationWinnerCells.append(moveBy.cell)
        }
        
        //adding padding so column will be transposed correctly for the validation
        validationWinnerCells.append(contentsOf: Array(repeating: nil, count: boardState.boardSize * boardState.boardSize - 3))
        
        let lastPlayed = boardState.moves.last!
        let winner = engine.checkWinner(for: lastPlayed.type)
        XCTAssertNotNil(winner)
        XCTAssertEqual(winner?.winningMark, .x)
        XCTAssertEqual(winner?.winningCells, validationWinnerCells.transposed()!.compactMap { $0?.swapped })
        XCTAssertEqual(winner?.rulesResult, .winning)
    }
    
    func testPlayerHasWinnerInAColumn() throws {
        let boardState = BoardStateImpl(moves: [], boardSize: 10)
        let engineRules = EngineRulesImpl(boardState: boardState)
        let engine = Engine(boardState: boardState, engineRules: engineRules)
        var validationWinnerCells = [CellCoordinate?]()
        for j in 0..<boardState.boardSize {
            let moveBy = BoardCell(type: .x, toCell: .init(row: j, column: 0))
            boardState.addMove(moveBy)
            validationWinnerCells.append(moveBy.cell)
        }
        
        validationWinnerCells = validationWinnerCells.map({ $0?.swapped })
        
        //adding padding so column will be transposed correctly for the validation
        validationWinnerCells.append(contentsOf: Array(repeating: nil, count: boardState.boardSize * boardState.boardSize - boardState.boardSize))
        
        let lastPlayed = boardState.moves.last!
        let winner = engine.checkWinner(for: lastPlayed.type)
        XCTAssertNotNil(winner)
        XCTAssertEqual(winner?.winningMark, .x)
        XCTAssertEqual(winner?.winningCells, validationWinnerCells.transposed()!.compactMap { $0 })
        XCTAssertEqual(winner?.rulesResult, .winning)
    }
    
    func testPlayerHasThreeInADiagonal() throws {
        let boardState = BoardStateImpl(moves: [], boardSize: 3)
        let engineRules = EngineRulesImpl(boardState: boardState)
        let engine = Engine(boardState: boardState, engineRules: engineRules)
        var validationWinnerCells = [CellCoordinate]()
        for j in 0..<boardState.boardSize {
            let moveBy = BoardCell(type: .x, toCell: .init(row: j, column: j))
            boardState.addMove(moveBy)
            validationWinnerCells.append(moveBy.cell)
        }
        
        let lastPlayed = boardState.moves.last!
        let winner = engine.checkWinner(for: lastPlayed.type)
        XCTAssertNotNil(winner)
        XCTAssertEqual(winner?.winningMark, .x)
        XCTAssertEqual(winner?.winningCells, validationWinnerCells)
        XCTAssertEqual(winner?.rulesResult, .winning)
    }
    
    func testAllCellsAreFilledAndDrawHappen() throws {
        let move1 = BoardCell(type: .o, toCell: .init(row: 0, column: 0))
        let move2 = BoardCell(type: .x, toCell: .init(row: 0, column: 1))
        let move3 = BoardCell(type: .o, toCell: .init(row: 0, column: 2))
        
        let move11 = BoardCell(type: .o, toCell: .init(row: 1, column: 0))
        let move12 = BoardCell(type: .x, toCell: .init(row: 1, column: 1))
        let move13 = BoardCell(type: .x, toCell: .init(row: 1, column: 2))
        
        let move21 = BoardCell(type: .x, toCell: .init(row: 2, column: 0))
        let move22 = BoardCell(type: .x, toCell: .init(row: 2, column: 1))
        
        let moves = [move1, move2, move3, move11, move12, move13, move21, move22]
        let boardState = BoardStateImpl(moves: moves, boardSize: 3)
        let engineRules = EngineRulesImpl(boardState: boardState)
        let engine = Engine(boardState: boardState, engineRules: engineRules)
        let lastMove = BoardCell(type: .o, toCell: .init(row: 2, column: 2))
        let winner = engine.makeMove(by: lastMove)
        XCTAssertNotNil(winner)
        XCTAssertEqual(winner.winningMark, .none)
        XCTAssertNil(winner.winningCells)
        XCTAssertEqual(winner.rulesResult, .draw)
    }
    
    func testBoardIsFull() throws {
        let boardState = BoardStateImpl(moves: [], boardSize: 3)
        let engineRules = EngineRulesImpl(boardState: boardState)
        
        var alt = true
        for i in 0..<boardState.boardSize {
            for j in 0..<boardState.boardSize {
                let moveBy = BoardCell(type: alt ? .x : .o, toCell: .init(row: i, column: j))
                boardState.addMove(moveBy)
                alt = !alt
            }
        }
        
        let anotherMove = BoardCell(type: .o, toCell: .init(row: 3, column: 3))
        XCTAssertEqual(engineRules.checkMoveIsValid(move: anotherMove), .noMoreMovesAllowedError)
    }
    
    func testAllCellsAreFilledAndXPlayerHasWon() throws {
        let boardState = BoardStateImpl(moves: [], boardSize: 3)
        let engineRules = EngineRulesImpl(boardState: boardState)
        let engine = Engine(boardState: boardState, engineRules: engineRules)
        var validationWinnerCells = [CellCoordinate]()
        var alt = true
        for i in 0..<boardState.boardSize {
            for j in 0..<boardState.boardSize {
                let moveBy = BoardCell(type: alt ? .x : .o, toCell: .init(row: i, column: j))
                boardState.addMove(moveBy)
                alt = !alt
            }
        }
        validationWinnerCells = [
            .init(row: 0, column: 0),
            .init(row: 1, column: 1),
            .init(row: 2, column: 2),
        ]
        
        let nextMove = BoardCell(type: .o, toCell: .init(row: 3, column: 3))
        let winner = engine.makeMove(by: nextMove)
        XCTAssertNotNil(winner)
        XCTAssertEqual(winner.winningMark, .x)
        XCTAssertEqual(winner.winningCells, validationWinnerCells)
        XCTAssertEqual(winner.rulesResult, .winning)
    }
    
    func testAllCellsAreFilledAndOPlayerHasWon() throws {
        let boardState = BoardStateImpl(moves: [], boardSize: 3)
        let engineRules = EngineRulesImpl(boardState: boardState)
        let engine = Engine(boardState: boardState, engineRules: engineRules)
        var validationWinnerCells = [CellCoordinate]()
        var alt = false
        for i in 0..<boardState.boardSize {
            for j in 0..<boardState.boardSize {
                let moveBy = BoardCell(type: alt ? .x : .o, toCell: .init(row: i, column: j))
                boardState.addMove(moveBy)
                alt = !alt
            }
        }
        
        validationWinnerCells = [
            .init(row: 0, column: 0),
            .init(row: 1, column: 1),
            .init(row: 2, column: 2),
        ]
        
        let nextMove = BoardCell(type: .x, toCell: .init(row: 3, column: 3))
        
        let winner = engine.makeMove(by: nextMove)
        XCTAssertNotNil(winner)
        XCTAssertEqual(winner.winningMark, .o)
        XCTAssertEqual(winner.winningCells, validationWinnerCells)
        XCTAssertEqual(winner.rulesResult, .winning)
    }
}
