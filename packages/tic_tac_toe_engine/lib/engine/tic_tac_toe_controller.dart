import 'package:tic_tac_toe_engine/engine/tic_tac_toe_scoreboard.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

/// Game Controller for TicTacToe
///
class TicTacToeController {
  /// Scoreboard for the current controller
  final TicTacToeScoreboard scoreboard;

  /// If set to true then once a winner is found
  /// or no more moves can be made, the game will
  /// restart itself.
  ///
  /// Use the [TicTacToeController.restart] method to
  /// perform the game restart manually.
  ///
  final bool autoRestartGame = false;

  TicTacToeController({
    TicTacToeScoreboard? scoreboard,
  })  : scoreboard = scoreboard ?? TicTacToeScoreboard(),
        _gameState = TicTacToeStateCTRL();

  final TicTacToeStateCTRL _gameState;

  TicTacToeState get state => _gameState;

  void makeMove(int index) => _gameState.makeMove(index);
}
