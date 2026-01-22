//
//  CellView.swift
//  TicTacToe
//
//  Created by 2026-DEV2-025 on 22/01/2026.
//

import SwiftUI

struct CellView : View {
    let cellId: Int
    var body: some View {
        Rectangle()
            .fill(Color.blue.opacity(0.7))
            .aspectRatio(1, contentMode: .fit) // forces square cells within the row
            .frame(maxWidth: .infinity, maxHeight: .infinity)

    }
}
