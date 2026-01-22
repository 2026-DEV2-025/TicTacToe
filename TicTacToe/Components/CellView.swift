//
//  CellView.swift
//  TicTacToe
//
//  Created by 2026-DEV2-025 on 22/01/2026.
//

import SwiftUI

enum CellState: String, Equatable { //fixme: move to the engine
    case x = "xmark", o = "circle", none = ""
}

struct CellView : View {
    let cellId: Int
    var cellState: CellState
    var body: some View {
        drawButton(with: cellState)
        .aspectRatio(1, contentMode: .fit)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        
    }

    func drawButton(with cellState: CellState) -> some View {
        GeometryReader { geo in
                let side = geo.size.width * 0.7

                Image(systemName: "circle")
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
