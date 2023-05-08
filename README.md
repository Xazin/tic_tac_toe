# Tic Tac Toe Engine

This project features a simple game engine for building Tic Tac Toe games. The project is built to be highly customizable, allowing for multiple different types of implementations.

## Features

The below is a list of features that have been implemented.

Pure dart engine:

- [x] Built-in Scoreboard
- [x] Configurable Rules (Number of Rows and Columns, Number of consecutive moves to win)
- [x] Current Game Info (How many moves, which players turn)
- [x] Game History

Flutter widgets:

- [x] TicTacToeBuilder - Simple builder widget that rebuilds on game state changes
- [ ] TicTacToeView - Dynamic TicTacToe board built depending on game settings, and can be themed
- [ ] TicTacToeScoreboard - Simple scoreboard
- [ ] TicTacToeScoreboardOverlay - Simple scoreboard that can be shown/hid

_The below is a list of features that **could** be interesting to explore, and expand the project with:_

- [ ] Variable amount of Players (Turn your game into a battle royale!) - Fits well with larger grids
- [ ] Persistence Helpers

## State mechanism

The engine uses [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html)'s to offer updates on current game state and the scoreboard. This allows the consumer to only listen to what is relevant, eg. the scoreboard can be implemented separately based on just the updates from the game state.

The game is controlled via one event only, which is the `makeMove` event. The controller feeds the event downwards to the game state manager, and the result of the move from the manager is returned back to the controller, which then accordingly updates the scoreboard.

A simple diagram to illustrate the architecture is attached below, please note that it is not displayed for accuracy, but to illustrate how a consumer can use the game state and scoreboard separately.

![Consumer view](.github/consuming.png)

_If requested, a more accurate version of the state architecture can be drawn._

# Notes

Game Rules

<!-- /// [0, 1, 2, 3, 4, ..8]
///
/// - At least 5 moves to a win (Impl. game state)
/// - Win condition: 3 in a row (horizontal, vertical, diagonal)
///
/// - >= 9 Moves is a Draw
///
/// Player 1 & 2 - Notify which one is performing a move
///

/// Game Widgets
/// - [GameBoard] Default GridView w/ Callbacks
///
/// Configurations/Customization:
/// - Scoreboard (Overlay)
/// - Players (O, X) - Animations
/// - GameBoard (Padding, Borders, Background, Margin)
/// - Size of Board - Derive constraints for children (Grid Tiles)
/// - Interactions (onEnter, onExit, onPressed) -->

Game Controller

<!-- // class GameEngine {
//   /// Notify about changes
//   /// Consume events from outside
//   /// Track state
//   ///
//   late final List<int> _board;

//   GameEngine() {
//     _board = List.generate(rows * cols, (_) => 0);
//   }

//   /// Listen to game end and then grab game state
//   /// eg. who won (if any)
//   ///
//   final ValueNotifier<GameState> gameState = ValueNotifier(GameState.initial());

//   /// Reset GameState
//   void reset() {
//     /// Change gameState to initial, but keep track of scores
//   }

//   Future<void> makeMove(int index) {
//     /// Check if game is still running
//     ///
//     /// Check if index is occupied
//     ///
//     /// Change current player
//     ///
//     /// Check if game ended due to this move
//   }

//   /// Read from GameState
//   int get _getPlayer => _isPlayerOne ? 1 : 2;
// }

// class GameState {
//   List<int> board;
//   List<int> scores;

//   /// [0 = draws, 1 = Player 1 wins, 2 = Player 2 wins]
//   bool isRunning;
//   int? winner;
//   bool isPlayerOne;
// } -->

Win Validation

<!-- /// [0, 1, 2]
/// [3, 4, 5]
/// [6, 7, 8]
///
/// -1 = nothing changed
///
/// 0 = no state
/// 1 = Player 1 (O)
/// 2 = Player 2 (X)
///
// class WinValidator {
//   static int gameEnded(List<int> currentMoveset) {
//     /// Horizontal
//     if (currentMoveset[0] == currentMoveset[1] &&
//         currentMoveset[0] == currentMoveset[2]) {}

//     /// Vertical

//     /// Diagonal

//     return -1;
//   }
// } -->
