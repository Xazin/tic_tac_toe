import 'package:flutter/material.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

import 'score_box.dart';

class ScoreboardBoxes extends StatelessWidget {
  const ScoreboardBoxes({
    super.key,
    required this.scoreboard,
  });

  final TicTacToeScoreboard scoreboard;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool unboundedWidth = true;
      if (constraints.maxWidth > 150 * 2 + 10) {
        /// BoxConstraint.maxWidth is 150, spacing between is 10
        unboundedWidth = false;
      }

      return Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // Scoreboard Widgets
          ScoreBox(
            score: scoreboard.playerOne,
            player: TicTacToePlayer.playerOne,
            unboundedWidth: unboundedWidth,
          ),
          ScoreBox(
            score: scoreboard.playerTwo,
            player: TicTacToePlayer.playerTwo,
            unboundedWidth: unboundedWidth,
          ),
          ScoreBox(
            score: scoreboard.draws,
            player: TicTacToePlayer.none,
            unboundedWidth: unboundedWidth,
          ),
          ScoreBox(
            score: scoreboard.totalGames,
            unboundedWidth: unboundedWidth,
          ),
        ],
      );
    });
  }
}
