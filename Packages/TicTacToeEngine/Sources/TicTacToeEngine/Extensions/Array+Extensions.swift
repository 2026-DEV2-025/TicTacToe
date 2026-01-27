//
//  Array+Extensions.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 27/01/2026.
//

extension Array where Element == BoardCell? {
    func transposed() -> [BoardCell?] {
        let size = BOARD_SIZE * BOARD_SIZE
        var padded = Array<BoardCell?>(repeating: nil, count: size)
        for index in 0..<Swift.min(self.count, size) {
            padded[index] = self[index]
        }

        var transposed = Array<BoardCell?>(repeating: nil, count: size)
        for row in 0..<BOARD_SIZE {
            for col in 0..<BOARD_SIZE {
                let sourceIndex = row * BOARD_SIZE + col
                let targetIndex = col * BOARD_SIZE + row
                transposed[targetIndex] = padded[sourceIndex]
            }
        }
        return transposed
    }
    
    func diagonalTopLeftToBottomRight() -> [BoardCell?] {
        var diagonal: [BoardCell?] = []
        for i in 0..<BOARD_SIZE {
            diagonal.append(self[i * BOARD_SIZE + i])
        }
        return diagonal
    }
    
    func diagonalTopRightToBottomLeft() -> [BoardCell?] {
        var diagonal: [BoardCell?] = []
        for i in 0..<BOARD_SIZE {
            diagonal.append(self[i * BOARD_SIZE + (BOARD_SIZE - 1 - i)])
        }
        return diagonal
    }
}
