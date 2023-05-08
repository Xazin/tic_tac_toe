import 'package:tic_tac_toe_engine/engine/tic_tac_toe_scoreboard.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

/// Game Controller for TicTacToe
///
class TicTacToeController {
  /// Scoreboard for the current controller
  final TicTacToeScoreboard scoreboard;

  TicTacToeController({
    TicTacToeScoreboard? scoreboard,
    int rows = 3,
    int columns = 3,
    int winCondition = 3,
    bool autoRestartGame = false,
  })  : scoreboard = scoreboard ?? TicTacToeScoreboard(),
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

  /// Restarts current game manually
  void restartGame() => _gameState.restartGame();
}
