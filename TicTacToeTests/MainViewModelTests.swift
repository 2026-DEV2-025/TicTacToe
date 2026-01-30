//
//  MainViewModelTests.swift
//  TicTacToeTests
//
//  Created by 2026-DEV2-025 on 30/01/2026.
//

import XCTest
import TicTacToeEngine
@testable import TicTacToe

@MainActor
final class MainViewModelTests: XCTestCase {
    func testInitMirrorsBoardStatus() {
        let viewModel = MainViewModel(boardSize: 3)

        XCTAssertEqual(viewModel.status.text, viewModel.boardViewModel.currentStatus.text)
    }

    func testRestartGameResetsBoardState() {
        let viewModel = MainViewModel(boardSize: 3)

        viewModel.boardViewModel.tapCell(row: 0, column: 0)
        viewModel.boardViewModel.tapCell(row: 0, column: 1)
        viewModel.restartGame()

        XCTAssertEqual(viewModel.boardViewModel.currentStatus.text, Strings.Status.xTurn)
        XCTAssertTrue(viewModel.boardViewModel.cells.allSatisfy { $0.mark == .none })
        XCTAssertEqual(viewModel.status.text, Strings.Status.xTurn)
    }
}
