import 'package:flutter/material.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

class ScoreBox extends StatelessWidget {
  final int score;

  /// Which [TicTacToePlayer] the score refers to.
  /// If null it will expect this to display the
  /// total games played.
  ///
  final TicTacToePlayer? player;

  final bool unboundedWidth;

  const ScoreBox({
    super.key,
    required this.score,
    this.player,
    this.unboundedWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: unboundedWidth
          ? const BoxConstraints()
          : const BoxConstraints(maxWidth: 150),
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: player == null
                    ? Colors.black
                    : Colors.white.withOpacity(0.05), // 5%
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Text(
                      score.toString(),
                      style: const TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _refFromPlayer,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String get _refFromPlayer {
    switch (player) {
      case TicTacToePlayer.none:
        return 'Draws';
      case TicTacToePlayer.playerOne:
        return 'Player 1';
      case TicTacToePlayer.playerTwo:
        return 'Player 2';
      default:
        return 'Total games';
    }
  }
}
