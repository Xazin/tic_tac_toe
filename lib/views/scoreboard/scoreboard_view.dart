import 'package:flutter/material.dart';
import 'package:tic_tac_toe_eng/views/scoreboard/widgets/history.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

import 'widgets/scoreboard_boxes.dart';
import 'widgets/settings_button.dart';

class ScoreboardView extends StatelessWidget {
  final TicTacToeController controller;

  final bool includeHistory;

  const ScoreboardView({
    super.key,
    required this.controller,
    this.includeHistory = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 39, 39, 39),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              SettingsButton(
                controller: controller,
              ),
              if (includeHistory) ...[
                const SizedBox(height: 15),
                Expanded(child: History(scoreboard: controller.scoreboard)),
                const SizedBox(height: 15),
              ] else ...[
                const Spacer(),
              ],
              ScoreboardBoxes(scoreboard: controller.scoreboard),
            ],
          ),
        ),
      ),
    );
  }
}
