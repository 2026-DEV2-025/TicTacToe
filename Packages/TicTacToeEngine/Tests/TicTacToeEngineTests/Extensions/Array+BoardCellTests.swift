//
//  Array+BoardCellTests.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 27/01/2026.
//

import XCTest
@testable import TicTacToeEngine

final class Array_BoardCellTests: XCTestCase {
    
    func testTransposing() {
        let array: [BoardCell?] = [
            nil, nil, nil,
            .init(row: 1, column: 0), nil, nil,
            nil, nil, nil
        ]
        
        let expected: [BoardCell?] = [
            nil, .init(row: 0, column: 1), nil,
            nil, nil, nil,
            nil, nil, nil
        ]

        XCTAssertEqual(array.transposed(), expected)
    }
    
    func testTransposingOnNonSquareMatrix() {
        let array: [BoardCell?] = [
            nil, nil, nil,
            .init(row: 1, column: 0), nil, nil,
            nil
        ]

        XCTAssertNil(array.transposed())
    }

    func testDiagonalsOnNonSquareMatrix() {
        let array: [BoardCell?] = [
            nil, nil, nil,
            .init(row: 1, column: 0), nil, nil,
            nil
        ]

        XCTAssertNil(array.diagonalTopLeftToBottomRight())
        XCTAssertNil(array.diagonalTopRightToBottomLeft())
    }

    func testTransposingWithSomeNilItems() {
        let array: [BoardCell?] = [
            .init(row: 0, column: 0), .init(row: 0, column: 1), .init(row: 0, column: 2),
            nil, .init(row: 1, column: 1), .init(row: 1, column: 2),
            .init(row: 2, column: 0), .init(row: 2, column: 1), nil
        ]
        
        let expected: [BoardCell?] = [
            .init(row: 0, column: 0), nil, .init(row: 0, column: 2),
            .init(row: 1, column: 0), .init(row: 1, column: 1), .init(row: 1, column: 2),
            .init(row: 2, column: 0), .init(row: 2, column: 1), nil
        ]

        guard let transposed = array.transposed() else {
            XCTFail("Failed to transpose array")
            return
        }
        XCTAssertEqual(transposed, expected)
        XCTAssertEqual(transposed[2], BoardCell(row: 0, column: 2))
        XCTAssertEqual(transposed[3], BoardCell(row: 1, column: 0))
    }
    
}
