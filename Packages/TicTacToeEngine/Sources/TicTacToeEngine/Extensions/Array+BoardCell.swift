//
//  Array+Extensions.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 27/01/2026.
//

import Foundation

extension Array where Element == BoardCell? {
    func transposed() -> [BoardCell?]? {
        let boardSide = Int(Double(count).squareRoot())
        guard boardSide * boardSide == count else {
            return nil
        }

        var padded = Array<BoardCell?>(repeating: nil, count: count)
        for index in 0..<Swift.min(self.count, count) {
            padded[index] = self[index]
        }

        var transposed = Array<BoardCell?>(repeating: nil, count: count)
        for row in 0..<boardSide {
            for col in 0..<boardSide {
                let sourceIndex = row * boardSide + col
                let targetIndex = col * boardSide + row
                if let cell = padded[sourceIndex] {
                    transposed[targetIndex] = BoardCell(row: cell.column, column: cell.row)
                } else {
                    transposed[targetIndex] = nil
                }
            }
        }
        return transposed
    }
    
    func diagonalTopLeftToBottomRight() -> [BoardCell?]? {
        let size = Int(Double(count).squareRoot())
        guard size * size == count else {
            return nil
        }
        var diagonal: [BoardCell?] = []
        for i in 0..<size {
            diagonal.append(self[i * size + i])
        }
        return diagonal
    }
    
    func diagonalTopRightToBottomLeft() -> [BoardCell?]? {
        let size = Int(Double(count).squareRoot())
        guard size * size == count else {
            return nil
        }
        var diagonal: [BoardCell?] = []
        for i in 0..<size {
            diagonal.append(self[i * size + (size - 1 - i)])
        }
        return diagonal
    }
}
