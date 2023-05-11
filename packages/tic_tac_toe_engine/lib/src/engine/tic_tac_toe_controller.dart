import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

import 'tic_tac_toe_state.dart';

/// Game Controller for TicTacToe
///
class TicTacToeController {
  /// Scoreboard for the current controller
  final TicTacToeScoreboard scoreboard;

  final int _rows;
  int get rows => _rows;

  final int _columns;
  int get columns => _columns;

  TicTacToeController({
    TicTacToeScoreboard? scoreboard,
    int rows = 3,
    int columns = 3,
    int winCondition = 3,
    bool autoRestartGame = false,
  })  : scoreboard = scoreboard ?? TicTacToeScoreboard(),
        _rows = rows,
        _columns = columns,
        _gameState = TicTacToeStateController(
          autoRestartGame: autoRestartGame,
          rows: rows,
          columns: columns,
          winCondition: winCondition,
        ) {
    _gameState.addListener(() {
      if (_gameState.gameEnded) {
        this.scoreboard.add(_gameState.winner!);
      }
    });
  }

  final TicTacToeStateController _gameState;

  TicTacToeState get state => _gameState;

  /// Makes a move
  void makeMove(int index) => _gameState.makeMove(index);

  /// Restarts current game
  void restartGame() => _gameState.restartGame();
}
