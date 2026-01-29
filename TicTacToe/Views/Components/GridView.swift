//
//  Grid.swift
//  TicTacToe
//
//  Created by 2026-DEV2-025 on 22/01/2026.
//

import SwiftUI
import TicTacToeEngine

struct GridView : View {

    @ObservedObject var viewModel: BoardViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ForEach(0..<viewModel.boardSize, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<viewModel.boardSize, id: \.self) { col in
                            let cell = viewModel.cell(atRow: row, column: col)
                            CellView(cellId: row * viewModel.boardSize + col, cellState: cell?.mark.asMarkIcon ?? .none)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    viewModel.tapCell(row: row, column: col)
                                }
                            if col < viewModel.boardSize - 1 {
                                Divider()
                                    .background(Color.black)
                            }
                        }
                    }
                    if row < viewModel.boardSize - 1 {
                        Divider()
                            .background(Color.black)
                    }
                }
            }
            if let winningIndexes = winningIndexes {
                WinningLineView(gridSize: viewModel.boardSize, winningIndexes: winningIndexes)
            }
        }
    }

    private var winningIndexes: [[Int]]? {
        guard
            let winningCells = viewModel.winningCells,
            let first = winningCells.first,
            let last = winningCells.last
        else {
            return nil
        }
        return [
            [first.column + 1, first.row + 1],
            [last.column + 1, last.row + 1]
        ]
    }
}

#Preview {
    GridView(viewModel: BoardViewModel(boardSize: 3))
        .frame(width: 300, height: 300)
        .position(x: 157, y: 157)
}
