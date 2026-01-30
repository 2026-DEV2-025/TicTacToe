//
//  MainViewModel.swift
//  TicTacToe
//
//  Created by 2026-DEV2-025 on 29/01/2026.
//

import SwiftUI
import TicTacToeEngine
import Combine


@MainActor
final class MainViewModel: ObservableObject {
    let boardViewModel: BoardViewModel
    let engine: TicTacToeEngine
    let boardSize: Int
    @Published private(set) var status: Status
    
    init(engine: TicTacToeEngine, boardSize: Int) {
        self.engine = engine
        self.boardSize = boardSize
        self.boardViewModel = BoardViewModel(engine: engine, boardSize: boardSize)
        self.status = boardViewModel.currentStatus
        self.boardViewModel.onStatusUpdate = { [weak self] status in
            self?.status = status
        }
    }

    convenience init(boardSize: Int = 3) {
        let engine = TicTacToeEngine(boardSize: boardSize)
        self.init(engine: engine, boardSize: boardSize)
    }
    
    deinit {
        //adding empty deinit because of pointer being freed was not allocated crash
        //well explained here: https://www.monkey.work/blog/2025-11-18-swift-ui-pointer-being-freed-was-not-allocated/
    }

    func restartGame() {
        boardViewModel.reset()
    }
    
    
    
}
