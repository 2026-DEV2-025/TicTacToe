# TicTacToe

## 1.0.0 - Unreleased

## TicTacToe game for 2 players.
Project kata for showing TDD in TicTacToeEngine, with DI-friendly design for better testing.
Project is split into TicTacToeEngine, which is strictly game logic, state, and rules with the idea of complete isolation from the UI, and the main app module where Views with ViewModels live.

## Rules of the game
- X always goes first.
- Players cannot play on a played position.
- Players alternate placing X’s and O’s on the board until either:
    - One player has three in a row, horizontally, vertically, or diagonally
    - All nine squares are filled.
- If a player is able to draw three X’s or three O’s in a row, that player wins.
- If all nine squares are filled and neither player has three in a row, the game is a draw.

## Running the app
### Requirements: 
min `Xcode 26.1` (could be `Xcode 16` but not tested)
### Running on target
Open the `TicTacToe.xcworkspace` and run on target. Minimum iOS target is set to `16.6`. No third-party components were used, so it will run out of the box.

## Running the unit tests
Select the TicTacToe target to run tests for the app module
Select the TicTacToeEngine target to run tests for the engine module

## Git approach
### To make the main branch always green in terms of tests and compilation, each feature or fix was taken to a separate branch. List of branches:
    - feature/additional_tests_for_view_models
    - feature/game_status
    - feature/restart_button
    - feature/ui_integration_with_engine
    - feature/tictactoe_engine_public_api
    - tictactoe_engine
    - view_components
    
Each branch was merged to `main` with squash merge via PR after all work is done, so work in progress or failing tests commits did not break `main`. Unfortunately, because of no CI setup, which would fail and indicate a failing branch, one branch broke a couple of tests on main, which was fixed afterward with a new PR.
Final release is tagged with version 1.0.0.

## Planned improvements 
- Optimise engine, especially checking the winner part
- Unit tests could be better deduplicated in the engine
- Expose move history to the app and implement Undo button
- Persistence between launches using Defaults storage, as the data is simple

## Enjoy reviewing the app!
