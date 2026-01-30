//
//  Status.swift
//  TicTacToe
//
//  Created by 2026-DEV2-025 on 30/01/2026.
//

import SwiftUI

struct Status {
    let color: Color
    let text: String
    
    init(color: Color, text: String) {
        self.color = color
        self.text = text
    }
    
    static var empty: Self {
        .init(color: .clear, text: "")
    }
}
