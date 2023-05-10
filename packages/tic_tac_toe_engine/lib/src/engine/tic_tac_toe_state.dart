import 'package:flutter/widgets.dart';
import 'package:tic_tac_toe_engine/src/engine/tic_tac_toe_player.dart';
import 'package:tic_tac_toe_engine/src/engine/tic_tac_toe_win_validator.dart';

/// State object for TicTacToe
abstract class TicTacToeState extends ChangeNotifier {
  /// Current board
  late List<TicTacToePlayer> _board;

  List<TicTacToePlayer> get board => _board;

  /// Validator based on rules and playing field
  late final WinValidator _validator;

  int _moves;

  /// Amount of moves performed in the current game
  int get moves => _moves;

  bool _gameEnded;

  /// Whether the current game has ended
  bool get gameEnded => _gameEnded;

  TicTacToePlayer? _winner;

  /// Winner of this game if gameEnded
  TicTacToePlayer? get winner => _winner;

  /// Current player, who is making the next move
  TicTacToePlayer get currentPlayer =>
      (moves % 2) == 0 ? TicTacToePlayer.playerOne : TicTacToePlayer.playerTwo;

  TicTacToeState({
    int moves = 0,
    bool gameEnded = false,
    int rows = 3,
    int columns = 3,
  })  : _moves = moves,
        _gameEnded = gameEnded;
}

/// State object for TicTacToe w/ control methods
/// Preferred to use [TicTacToeController] to communicate
/// with the state.
///
/// In the case that as a consumer you want to implement
/// independant features eg. own scoreboard, or similar,
/// then this class can be used directly.
class TicTacToeStateController extends TicTacToeState {
  final bool autoRestartGame;

  late final int _tiles;

  TicTacToeStateController({
    super.moves = 0,
    super.gameEnded = false,
    this.autoRestartGame = false,
    int rows = 3,
    int columns = 3,
    int winCondition = 3,
  }) : assert(rows > 2 && columns > 2) {
    _tiles = rows * columns;
    _board = List.generate(_tiles, (_) => TicTacToePlayer.none);
    _validator = WinValidator(
      rows: rows,
      columns: columns,
      winCondition: winCondition,
    );
  }

  /// Reset game
  void restartGame() {
    _moves = 0;
    _gameEnded = false;
    _winner = null;
    _board.fillRange(0, _tiles, TicTacToePlayer.none);
    notifyListeners();
  }

  /// For the current player, try to occupy the field at [index]
  void makeMove(int index) {
    /// Illegal move when
    ///  - someone is occupying this field
    ///  - game has already ended
    ///  - index is lower than 0 or higher than amount of tiles
    if (_gameEnded ||
        _board[index] != TicTacToePlayer.none ||
        index < 0 ||
        index > _tiles - 1) {
      return;
    }

    final player = currentPlayer;

    _board[index] = player;
    _moves++;

    if (winningIsPossible) {
      if (_validator.validate(_board, index)) {
        _endGame(player);
      }

      // Draw condition
      if (!_gameEnded && _moves == _tiles) {
        _endGame(TicTacToePlayer.none);
      }
    } else {
      notifyListeners();
    }

    if (_gameEnded && autoRestartGame) {
      restartGame();
    }

    if (!_gameEnded && winningIsPossible) {
      notifyListeners();
    }
  }

  bool get winningIsPossible => _moves >= (_validator.winCondition * 2 - 1);

  void _endGame(TicTacToePlayer winner) {
    _gameEnded = true;
    _winner = winner;
    notifyListeners();
  }
}
