//
//  TicTacToeEngine.swift
//  TicTacToeEngine
//
//  Created by 2026-DEV2-025 on 29/01/2026.
//

public final class TicTacToeEngine {
    private let boardSize: Int
    private var boardState: BoardState
    private var engine: Engine

    public init(boardSize: Int = 3) {
        precondition(boardSize > 0, "Board size must be greater than 0")
        self.boardSize = boardSize
        self.boardState = BoardStateImpl(moves: [], boardSize: boardSize)
        self.engine = Engine(
            boardState: boardState,
            engineRules: EngineRulesImpl(boardState: boardState)
        )
    }

    public func makeMove(mark: Mark, cell: Cell) -> MovingResult {
        let move = PlayerMove(
            player: .init(type: mark.asPlayerType),
            toCell: cell.asBoardCell
        )
        let engineResult = engine.makeMove(by: move)
        
        return toMovingResult(engineResult)
    }

    public func boardCells() -> [Cell] {
        var occupants = Array(repeating: PlayerType.none, count: boardSize * boardSize)
        for move in boardState.moves {
            let index = (move.cell.row * boardSize) + move.cell.column
            if index >= 0 && index < occupants.count {
                occupants[index] = move.player.type
            }
        }

        return occupants.enumerated().map { index, playerType in
            let row = index / boardSize
            let column = index % boardSize
            return Cell(row: row, column: column, mark: playerType.asMark)
        }
    }

    public func reset() {
        boardState = BoardStateImpl(moves: [], boardSize: boardSize)
        engine = Engine(
            boardState: boardState,
            engineRules: EngineRulesImpl(boardState: boardState)
        )
    }
}

private extension TicTacToeEngine {
    func toMovingResult(_ result: EngineResult) -> MovingResult {
        return MovingResult(
            mark: result.winningMark.asMark,
            cells: result.winningCells?.map {
                Cell(boardCell: $0, mark: result.winningMark.asMark)
            },
            rulesResult: toRulesResult(result),
            winningResult: toWinResult(result)
        )
    }
    
    func toWinResult(_ result: EngineResult) -> WiningResult {
        switch result.rulesResult {
        case .winning:
            return .win
        case .draw:
            return .draw
        default:
            return .none
        }
    }

    func toRulesResult(_ result: EngineResult) -> RulesResult {
        switch result.rulesResult {
        case .moveSucceeded:
            return .moveSucceeded
        case .onlyXMustStartError:
            return .onlyXMustStartError
        case .cellIsAlreadyTakenError:
            return .cellIsAlreadyTakenError
        case .mustAlternateTurnsError:
            return .mustAlternateTurnsError
        case .noMoreMovesAllowedError:
            return .noMoreMovesAllowedError
        case .winning:
            return .moveSucceeded
        case .draw:
            return .noMoreMovesAllowedError
        case .unknownError:
            return .unknownError

        }
    }
}
