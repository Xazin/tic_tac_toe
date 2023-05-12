import 'package:flutter/widgets.dart';
import 'package:tic_tac_toe_engine/src/engine/tic_tac_toe_player.dart';

/// Holds statistics about simultaneous games.
///
/// Can be used to instantiate a Game Controller with
/// previous statistics, to continue games between
/// eg. friends or family.
///
/// If the exact history of the games, who won when, is
/// irrelevant, then instantiate using [draws], [playerOne],
/// and [playerTwo], otherwise use [history]. Do not use
/// both.
///
class TicTacToeScoreboard extends ChangeNotifier {
  late final List<TicTacToePlayer> _history;

  /// Defaults to empty history without any previous games
  TicTacToeScoreboard({
    List<TicTacToePlayer>? history,
    int? draws,
    int? playerOne,
    int? playerTwo,
  }) : assert((history != null &&
                (draws == null && playerOne == null && playerTwo == null)) ||
            (history == null &&
                draws == null &&
                playerOne == null &&
                playerTwo == null) ||
            (history == null &&
                (draws != null || playerOne != null || playerTwo != null))) {
    _history = history ?? [];

    if (draws != null && draws > 0) {
      _addGames(draws, TicTacToePlayer.none);
    }

    if (playerOne != null && playerOne > 0) {
      _addGames(playerOne, TicTacToePlayer.playerOne);
    }

    if (playerTwo != null && playerTwo > 0) {
      _addGames(playerTwo, TicTacToePlayer.playerTwo);
    }

    notifyListeners();
  }

  List<TicTacToePlayer> get history => _history;

  int get totalGames => _history.length;

  /// Amount of Draws in the current session
  int get draws => history.where((e) => e == TicTacToePlayer.none).length;

  /// Amount of Player One wins in the current session
  int get playerOne =>
      history.where((e) => e == TicTacToePlayer.playerOne).length;

  /// Amount of Player Two wins in the current session
  int get playerTwo =>
      history.where((e) => e == TicTacToePlayer.playerTwo).length;

  /// Add a game to the scoreboard
  void add(TicTacToePlayer winner) {
    _history.add(winner);
    notifyListeners();
  }

  void _addGames(int count, TicTacToePlayer player) {
    _history.addAll(List.generate(count, (_) => player));
  }
}
