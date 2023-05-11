import 'package:flutter/material.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

class HistoryItem extends StatelessWidget {
  final TicTacToePlayer winner;

  const HistoryItem({
    super.key,
    required this.winner,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.5),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: winner == TicTacToePlayer.none ? '[DRAW] ' : '[WINNER] ',
              style: TextStyle(
                color: winner == TicTacToePlayer.none
                    ? Colors.red
                    : const Color(0xFF05FF00),
              ),
            ),
            TextSpan(text: _winnerFromPlayer),
          ],
        ),
      ),
    );
  }

  String get _winnerFromPlayer => winner == TicTacToePlayer.none
      ? 'No winner, game is a draw'
      : winner == TicTacToePlayer.playerOne
          ? 'Player 1 won the game'
          : 'Player 2 won the game';
}
