//
//  CellView.swift
//  TicTacToe
//
//  Created by 2026-DEV2-025 on 22/01/2026.
//

import SwiftUI

struct CellView : View {
    let cellId: Int
    var cellState: MarkIcon
    var body: some View {
        drawButton(with: cellState)
        .aspectRatio(1, contentMode: .fit)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        
    }

    func drawButton(with markIcon: MarkIcon) -> some View {
        GeometryReader { geo in
                let side = geo.size.width * 0.7

            Image(systemName: markIcon.rawValue)
                    .resizable()
                    .frame(width: side, height: side)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        
    }
}

#Preview {
    CellView(cellId: 1, cellState: .x)
    CellView(cellId: 2, cellState: .o)
    CellView(cellId: 3, cellState: .none)
}
