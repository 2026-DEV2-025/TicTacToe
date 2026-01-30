//
//  Strings.swift
//  TicTacToe
//
//  Created by 2026-DEV2-025 on 30/01/2026.
//

enum Strings {
    enum Status {
        static let xTurn = "X's turn"
        static let oTurn = "O's turn"
        static let cellAlreadyTaken = "That cell is already taken."
        static let onlyXMustStart = "Only X can start the game."
        static let mustAlternateTurns = "You must alternate turns."
        static let noMoreMoves = "No more moves allowed."
        static let unknownError = "Unknown error."
        static let draw = "Draw!"

        static func wins(_ mark: String) -> String {
            "\(mark) wins!"
        }

        static func turn(for mark: String) -> String {
            "\(mark)'s turn"
        }
    }

    enum Mark {
        static let x = "X"
        static let o = "O"
        static let unknown = "?"
    }
}
