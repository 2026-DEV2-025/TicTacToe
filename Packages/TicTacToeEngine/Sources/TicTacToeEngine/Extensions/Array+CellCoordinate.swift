//
//  Array+Extensions.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 27/01/2026.
//

import Foundation

extension Array where Element == CellCoordinate? {
    func transposed() -> [CellCoordinate?]? {
        let boardSide = Int(Double(count).squareRoot())
        guard boardSide * boardSide == count else {
            return nil
        }

        var padded = Array<CellCoordinate?>(repeating: nil, count: count)
        for index in 0..<Swift.min(self.count, count) {
            padded[index] = self[index]
        }

        var transposed = Array<CellCoordinate?>(repeating: nil, count: count)
        for row in 0..<boardSide {
            for col in 0..<boardSide {
                let sourceIndex = row * boardSide + col
                let targetIndex = col * boardSide + row
                if let cell = padded[sourceIndex] {
                    transposed[targetIndex] = CellCoordinate(row: cell.column, column: cell.row)
                } else {
                    transposed[targetIndex] = nil
                }
            }
        }
        return transposed
    }
    
    func diagonalTopLeftToBottomRight() -> [CellCoordinate?]? {
        let size = Int(Double(count).squareRoot())
        guard size * size == count else {
            return nil
        }
        var diagonal: [CellCoordinate?] = []
        for i in 0..<size {
            diagonal.append(self[i * size + i])
        }
        return diagonal
    }
    
    func diagonalTopRightToBottomLeft() -> [CellCoordinate?]? {
        let size = Int(Double(count).squareRoot())
        guard size * size == count else {
            return nil
        }
        var diagonal: [CellCoordinate?] = []
        for i in 0..<size {
            diagonal.append(self[i * size + (size - 1 - i)])
        }
        return diagonal
    }
}
