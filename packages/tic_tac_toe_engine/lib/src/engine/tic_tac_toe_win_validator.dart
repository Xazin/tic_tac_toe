import 'package:matrix2d/matrix2d.dart';
import 'package:tic_tac_toe_engine/src/engine/tic_tac_toe_config.dart';

import 'tic_tac_toe_player.dart';

class WinValidator {
  final TicTacToeConfig configuration;

  WinValidator({
    required this.configuration,
  });

  /// Validate if there is a winner of a given board
  ///
  /// Works with dynamic board sizes
  /// Eg. dynamic amount of rows & columns
  /// and any win condition that is valid.
  ///
  bool validate(List<TicTacToePlayer> board, int index) {
    final player = board[index];

    if (configuration.isStandardRules) {
      return _wonByStandardRules(board, player);
    }

    return _wonByDynamicRules(board, index, player);
  }

  bool _wonByDynamicRules(
    List<TicTacToePlayer> board,
    int index,
    TicTacToePlayer player,
  ) {
    final twoDBoard = board.reshape(configuration.rows, configuration.columns);

    /// Y Coordinate of current move in a 2D Array
    final y = index % configuration.columns;

    bool wonInARow = false;
    bool wonInAColumn = false;
    bool wonDiagonally = false;

    // Iterate Rows
    int inAColumn = 0;
    for (int i = 0; i < twoDBoard.length; i++) {
      int inARow = 0;

      // Vertical Check
      if (twoDBoard[i][y] == player) {
        inAColumn++;

        if (inAColumn >= configuration.winCondition) {
          wonInAColumn = true;
          break;
        }
      } else {
        inAColumn = 0;
      }

      // Iterate Columns
      for (int j = 0; j < twoDBoard[i].length; j++) {
        // Horizontal Check
        if (twoDBoard[i][j] == player) {
          inARow++;

          if (inARow >= configuration.winCondition) {
            wonInARow = true;
            break;
          }
        } else {
          inARow = 0;
        }

        if (configuration.winCondition <= twoDBoard.length - i) {
          // Diagonal Check from top-left to bottom-right
          if (configuration.winCondition <= twoDBoard[i].length - j) {
            bool diagonalWin = true;
            for (int k = 0; k < configuration.winCondition; k++) {
              if (twoDBoard[i + k][j + k] != player) {
                diagonalWin = false;
                break;
              }
            }

            if (diagonalWin) {
              wonDiagonally = true;
              break;
            }
          }

          // Diagonal Check from top-right to bottom-left
          if (configuration.winCondition <= j + 1) {
            bool diagonalWin = true;
            for (int k = 0; k < configuration.winCondition; k++) {
              if (twoDBoard[i + k][j - k] != player) {
                diagonalWin = false;
                break;
              }
            }

            if (diagonalWin) {
              wonDiagonally = true;
              break;
            }
          }
        }
      }

      if (wonInARow || wonInAColumn || wonDiagonally) {
        break;
      }
    }

    return wonInARow || wonInAColumn || wonDiagonally;
  }

  bool _wonByStandardRules(
      List<TicTacToePlayer> board, TicTacToePlayer player) {
    /// This is a readable way of writing the raw check for a winner
    /// which goes through all of the possible win options on a standard
    /// 3x3 Tic Tac Toe board.
    if (_allMatches([board[0], board[1], board[2]], player) ||
        _allMatches([board[3], board[4], board[5]], player) ||
        _allMatches([board[6], board[7], board[8]], player) ||
        _allMatches([board[0], board[3], board[6]], player) ||
        _allMatches([board[1], board[4], board[7]], player) ||
        _allMatches([board[2], board[5], board[8]], player) ||
        _allMatches([board[0], board[4], board[8]], player) ||
        _allMatches([board[2], board[4], board[6]], player)) {
      return true;
    }

    return false;
  }

  bool _allMatches(List<TicTacToePlayer> list, TicTacToePlayer player) =>
      list.every((occupant) => occupant == player);
}
