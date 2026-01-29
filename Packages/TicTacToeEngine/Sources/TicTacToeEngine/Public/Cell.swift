//
//  Cell.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 29/01/2026.
//

public final class Cell: Equatable {
    public let row: Int
    public let column: Int
    public let mark: Mark

    public init(row: Int, column: Int, mark: Mark = .none) {
        self.row = row
        self.column = column
        self.mark = mark
    }

    public static func == (lhs: Cell, rhs: Cell) -> Bool {
        lhs.row == rhs.row
        && lhs.column == rhs.column
        && lhs.mark == rhs.mark
    }
}

extension Cell {
    internal var asBoardCell: BoardCell {
        BoardCell(row: row, column: column)
    }

    internal convenience init(boardCell: BoardCell, mark: Mark) {
        self.init(row: boardCell.row, column: boardCell.column, mark: mark)
    }
}
