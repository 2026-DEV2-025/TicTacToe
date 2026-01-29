//
//  Array+CellCoordinateTests.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 27/01/2026.
//

import XCTest
@testable import TicTacToeEngine

final class Array_CellCoordinateTests: XCTestCase {
    
    func testTransposing() {
        let array: [CellCoordinate?] = [
            nil, nil, nil,
            .init(row: 1, column: 0), nil, nil,
            nil, nil, nil
        ]
        
        let expected: [CellCoordinate?] = [
            nil, .init(row: 0, column: 1), nil,
            nil, nil, nil,
            nil, nil, nil
        ]

        XCTAssertEqual(array.transposed(), expected)
    }
    
    func testTransposingOnNonSquareMatrix() {
        let array: [CellCoordinate?] = [
            nil, nil, nil,
            .init(row: 1, column: 0), nil, nil,
            nil
        ]

        XCTAssertNil(array.transposed())
    }

    func testDiagonalsOnNonSquareMatrix() {
        let array: [CellCoordinate?] = [
            nil, nil, nil,
            .init(row: 1, column: 0), nil, nil,
            nil
        ]

        XCTAssertNil(array.diagonalTopLeftToBottomRight())
        XCTAssertNil(array.diagonalTopRightToBottomLeft())
    }

    func testTransposingWithSomeNilItems() {
        let array: [CellCoordinate?] = [
            .init(row: 0, column: 0), .init(row: 0, column: 1), .init(row: 0, column: 2),
            nil, .init(row: 1, column: 1), .init(row: 1, column: 2),
            .init(row: 2, column: 0), .init(row: 2, column: 1), nil
        ]
        
        let expected: [CellCoordinate?] = [
            .init(row: 0, column: 0), nil, .init(row: 0, column: 2),
            .init(row: 1, column: 0), .init(row: 1, column: 1), .init(row: 1, column: 2),
            .init(row: 2, column: 0), .init(row: 2, column: 1), nil
        ]

        guard let transposed = array.transposed() else {
            XCTFail("Failed to transpose array")
            return
        }
        XCTAssertEqual(transposed, expected)
        XCTAssertEqual(transposed[2], CellCoordinate(row: 0, column: 2))
        XCTAssertEqual(transposed[3], CellCoordinate(row: 1, column: 0))
    }
    
}
