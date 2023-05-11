import 'package:flutter/material.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

import 'widgets/scoreboard_boxes.dart';
import 'widgets/settings_button.dart';

class ScoreboardView extends StatelessWidget {
  final TicTacToeScoreboard scoreboard;

  const ScoreboardView({
    super.key,
    required this.scoreboard,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 39, 39, 39),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SettingsButton(),
              const Spacer(),
              ScoreboardBoxes(scoreboard: scoreboard),
            ],
          ),
        ),
      ),
    );
  }
}
