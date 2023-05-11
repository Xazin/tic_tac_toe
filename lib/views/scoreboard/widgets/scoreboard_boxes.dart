import 'package:flutter/material.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

import 'score_box.dart';

class ScoreboardBoxes extends StatelessWidget {
  final TicTacToeScoreboard scoreboard;

  final bool isSmallView;

  const ScoreboardBoxes({
    super.key,
    required this.scoreboard,
    this.isSmallView = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool unboundedWidth = true;
      if (isSmallView || constraints.maxWidth > 150 * 2 + 10) {
        /// BoxConstraint.maxWidth is 150, spacing between is 10
        unboundedWidth = false;
      }

      return Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Statistics'),
          ),
          const Divider(height: 20),
          const SizedBox(height: 5),
          Wrap(
            spacing: isSmallView ? 8 : 10,
            runSpacing: isSmallView ? 8 : 10,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Scoreboard Widgets
              ScoreBox(
                score: scoreboard.playerOne,
                player: TicTacToePlayer.playerOne,
                unboundedWidth: unboundedWidth,
                isSmallBox: isSmallView,
              ),
              ScoreBox(
                score: scoreboard.playerTwo,
                player: TicTacToePlayer.playerTwo,
                unboundedWidth: unboundedWidth,
                isSmallBox: isSmallView,
              ),
              ScoreBox(
                score: scoreboard.draws,
                player: TicTacToePlayer.none,
                unboundedWidth: unboundedWidth,
                isSmallBox: isSmallView,
              ),
              ScoreBox(
                score: scoreboard.totalGames,
                unboundedWidth: unboundedWidth,
                isSmallBox: isSmallView,
              ),
            ],
          ),
        ],
      );
    });
  }
}
