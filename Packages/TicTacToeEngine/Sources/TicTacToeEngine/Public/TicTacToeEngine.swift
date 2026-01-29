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

    @discardableResult
    public func makeMove(mark: Mark, cell: Cell) -> MovingResult {
        print("AAA: Cell[\(cell.row):\(cell.column)], Mark: \(mark)")
        let boardCell = BoardCell(
            type: mark.asCellMarkType,
            toCell: .init(row: cell.row, column: cell.column)
        )
        let engineResult = engine.makeMove(by: boardCell)
        
        if let wc = engineResult.winningCells {
            print("AAA: Winning cells\(wc.map({ "\($0.row):\($0.column)" })) ")
        }
        
        return toMovingResult(engineResult)
    }

    public func boardCells() -> [Cell] {
        engine.boardCells().map({ .init(boardCell: $0) })
    }

    public func reset() {
        boardState = BoardStateImpl(moves: [], boardSize: boardSize)
        engine = Engine(
            boardState: boardState,
            engineRules: EngineRulesImpl(boardState: boardState)
        )
    }
    
    public func currentMark() -> Cell? {
        guard let lastPlayedMove = boardState.lastPlayedMove else {
            return nil
        }
        return .init(boardCell: lastPlayedMove)
    }
    
    public func emptyCells() -> [Cell] {
        return engine.emptyCells().map({ Cell(boardCell: $0) })
    }
    
    public func isCellAvailable(_ cell: Cell) -> Bool {
        return engine.emptyCells().first(where: {
            $0.cell.row == cell.row && $0.cell.column == cell.column
        }) != nil
    }
}

private extension TicTacToeEngine {
    func toMovingResult(_ result: EngineResult) -> MovingResult {
        return MovingResult(
            mark: result.winningMark.asMark,
            cells: result.winningCells?.map {
                Cell.init(row: $0.row, column: $0.column)
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
