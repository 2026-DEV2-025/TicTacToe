//
//  Grid.swift
//  TicTacToe
//
//  Created by 2026-DEV2-025 on 22/01/2026.
//

import SwiftUI

struct GridView : View {

    let gridSize: Int
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ForEach(0..<gridSize, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<gridSize, id: \.self) { col in
                            CellView(cellId: 1, cellState: .none)
                            Divider()
                                .background(Color.black)
                        }
                    }
                    Divider()
                        .background(Color.black)
                }
            }
            WinningLine(gridSize: gridSize, winningIndexes: [[1,1],[3,3]])
        }
    }
}

#Preview {
    GridView(gridSize: 3)
        .frame(width: 300, height: 300)
        .position(x: 157, y: 157)
}
