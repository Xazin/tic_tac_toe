import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

import 'tic_tac_toe_state.dart';

/// Game Controller for TicTacToe
///
class TicTacToeController {
  /// Scoreboard for the current controller
  final TicTacToeScoreboard scoreboard;

  TicTacToeConfig _configuration;
  TicTacToeConfig get configuration => _configuration;

  final TicTacToeStateController _gameState;
  TicTacToeState get state => _gameState;

  TicTacToeController({
    TicTacToeScoreboard? scoreboard,
    TicTacToeConfig? configuration,
  })  : scoreboard = scoreboard ?? TicTacToeScoreboard(),
        _configuration = configuration ?? TicTacToeConfig(),
        _gameState = TicTacToeStateController(
          configuration: configuration ?? TicTacToeConfig(),
        ) {
    _gameState.addListener(() {
      if (_gameState.gameEnded) {
        this.scoreboard.add(_gameState.winner!);
      }
    });
  }

  /// Makes a move
  void makeMove(int index) => _gameState.makeMove(index);

  /// Restarts current game
  void restartGame() => _gameState.restartGame();

  void updateConfiguration(TicTacToeConfig configuration) {
    _configuration = configuration;
    _gameState.updateConfiguration(configuration);
  }
}
