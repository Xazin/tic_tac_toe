import 'package:flutter/widgets.dart';
import 'package:tic_tac_toe_engine/engine/tic_tac_toe_player.dart';

abstract class TicTacToeState extends ChangeNotifier {
  /// Current board
  ///
  List<TicTacToePlayer> _board;

  /// Amount of moves performed in the current game
  ///
  int moves;

  /// Current state of the game
  ///
  bool gameEnded;

  /// Winner of this game
  ///
  TicTacToePlayer? winner;

  /// Current player, who can make a move
  TicTacToePlayer get currentPlayer =>
      (moves % 2) == 0 ? TicTacToePlayer.playerOne : TicTacToePlayer.playerTwo;

  TicTacToeState({
    this.moves = 0,
    this.gameEnded = false,
  }) : _board = [];
}

class TicTacToeStateCTRL extends TicTacToeState {
  TicTacToeStateCTRL({
    super.moves = 0,
    super.gameEnded = false,
  }) {
    _board = List.generate(9, (_) => TicTacToePlayer.none);
  }

  void makeMove(int index) {
    /// Illegal move - someone is occupying this field
    if (_board[index] != TicTacToePlayer.none) {
      return;
    }

    /// It's a draw
    if (moves >= 9) {
      moves++;
      _endGame(TicTacToePlayer.none);
    }

    moves++;
    _board[index] = currentPlayer;

    if (_evaluateWinner()) {
      _endGame(currentPlayer);
    }

    notifyListeners();
  }

  void _endGame(TicTacToePlayer winner) {
    gameEnded = true;
    winner = winner;
  }

  bool _evaluateWinner() {
    return false;
  }
}
