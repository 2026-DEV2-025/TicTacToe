//
//  WinningLineView.swift
//  TicTacToe
//
//  Created by 2026-DEV2-025 on 22/01/2026.
//

import SwiftUI

struct WinningLineView: View {
    var color: Color = .green
    var lineWidth: CGFloat = 6
    
    let gridSize: Int
    let winningIndexes:[[Int]]

    var body: some View {
        GeometryReader { geo in
            let cellSideLength = geo.size.width / CGFloat(gridSize)
            
            let startX = (cellSideLength * CGFloat(winningIndexes[0][0])) - cellSideLength / 2
            let startY = (cellSideLength * CGFloat(winningIndexes[0][1])) - cellSideLength / 2
            
            let endX = (cellSideLength * CGFloat(winningIndexes[1][0])) - (cellSideLength / 2)
            let endY = (cellSideLength * CGFloat(winningIndexes[1][1])) - (cellSideLength / 2)
                        
            Path { path in
                path.move(to: CGPoint(x: startX, y: startY))
                path.addLine(to: CGPoint(x: endX, y: endY))
            }
            .stroke(
                color,
                style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
            )
        }
    }
}

#Preview {
    WinningLineView(gridSize:3, winningIndexes: [[1,1],[3,3]])
        .frame(width: 200, height: 200)

    WinningLineView(gridSize:3, winningIndexes: [[1,3],[3,3]])
        .frame(width: 200, height: 200)
}
