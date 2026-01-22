//
//  Grid.swift
//  TicTacToe
//
//  Created by 2026-DEV2-025 on 22/01/2026.
//

import SwiftUI

struct GridView : View {
    

    
    let rows: Int
    let cols: Int
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<cols, id: \.self) { col in
                        CellView(cellId: 1)
                            Divider()
                                .background(Color.black)
                    }
                }
                Divider()
                    .background(Color.black)
            }
        }
    }
}

#Preview {
    GridView(rows: 4, cols: 4)
        .frame(width: 300, height: 300)
        .position(x: 157, y: 157)
}
