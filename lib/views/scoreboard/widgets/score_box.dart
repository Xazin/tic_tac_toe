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

  final bool isSmallBox;

  const ScoreBox({
    super.key,
    required this.score,
    this.player,
    this.unboundedWidth = true,
    this.isSmallBox = false,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: unboundedWidth
          ? const BoxConstraints()
          : BoxConstraints(maxWidth: isSmallBox ? 100 : 150),
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
                padding: EdgeInsets.symmetric(vertical: isSmallBox ? 10 : 20),
                child: Column(
                  children: [
                    Text(
                      score.toString(),
                      style: TextStyle(
                        fontSize: isSmallBox ? 22 : 28,
                      ),
                    ),
                    SizedBox(height: isSmallBox ? 2 : 5),
                    Text(
                      _refFromPlayer,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: isSmallBox ? 14 : 18,
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
