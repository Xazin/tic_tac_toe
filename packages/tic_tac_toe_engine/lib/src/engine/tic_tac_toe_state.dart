import 'package:flutter/widgets.dart';
import 'package:tic_tac_toe_engine/src/engine/tic_tac_toe_config.dart';
import 'package:tic_tac_toe_engine/src/engine/tic_tac_toe_player.dart';
import 'package:tic_tac_toe_engine/src/engine/tic_tac_toe_win_validator.dart';

/// State object for TicTacToe
abstract class TicTacToeState extends ChangeNotifier {
  /// Current board
  late List<TicTacToePlayer> _board;

  List<TicTacToePlayer> get board => _board;

  /// Validator based on rules and playing field
  late WinValidator _validator;
  WinValidator get validator => _validator;

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
  TicTacToeConfig _configuration;
  TicTacToeConfig get configuration => _configuration;

  late int _tiles;

  TicTacToeStateController({
    required TicTacToeConfig configuration,
    super.moves = 0,
    super.gameEnded = false,
    List<TicTacToePlayer>? board,
  }) : _configuration = configuration {
    _tiles = configuration.rows * configuration.columns;
    _board = board ?? List.generate(_tiles, (_) => TicTacToePlayer.none);
    _validator = WinValidator(configuration: configuration);
  }

  bool get winningIsPossible => _moves >= (configuration.winCondition * 2 - 1);

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

    if (_gameEnded && configuration.autoRestartGame) {
      restartGame();
    }

    if (!_gameEnded && winningIsPossible) {
      notifyListeners();
    }
  }

  void _endGame(TicTacToePlayer winner) {
    _gameEnded = true;
    _winner = winner;
    notifyListeners();
  }

  /// Can be used to load an existing board, eg. for
  /// network games where an on-going game might be
  /// done over multiple app lifecycles.
  ///
  void updateBoard(List<TicTacToePlayer> newBoard) {
    _board = newBoard;
    notifyListeners();
  }

  /// Used to update configuration without resetting
  /// the current board.
  ///
  void updateConfiguration(TicTacToeConfig config) {
    // Modified rows
    if (config.rows != _configuration.rows) {
      _updateRows(config.rows);
    }

    // Modified columns
    if (config.columns != _configuration.columns) {
      _updateColumns(config.columns, config.rows);
    }

    _configuration = config;
    _validator = WinValidator(configuration: config);
    _tiles = _configuration.rows * _configuration.columns;

    notifyListeners();
  }

  void _updateRows(int newRows) {
    final difference = newRows > _configuration.rows
        ? newRows - _configuration.rows
        : _configuration.rows - newRows;

    for (int i = 1; i == difference; i++) {
      if (newRows > _configuration.rows) {
        _board.addAll(
          List.filled(
            _configuration.columns,
            TicTacToePlayer.none,
          ),
        );
        continue;
      }

      _board.removeRange(
        _tiles - difference * _configuration.columns,
        _tiles,
      );
    }
  }

  void _updateColumns(int newColumns, int rows) {
    final difference = newColumns > _configuration.columns
        ? newColumns - _configuration.columns
        : _configuration.columns - newColumns;

    for (int i = 1; i <= rows; i++) {
      if (newColumns > _configuration.columns) {
        _board.insertAll(
          i * _configuration.columns,
          List.filled(difference, TicTacToePlayer.none),
        );
        continue;
      }

      _board.removeRange(
        (i * _configuration.columns) - i * difference,
        i * _configuration.columns - ((i - 1) * difference),
      );
    }
  }
}
