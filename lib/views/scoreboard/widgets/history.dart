import 'package:flutter/material.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

import 'history_item.dart';

class History extends StatelessWidget {
  final TicTacToeScoreboard scoreboard;

  const History({
    super.key,
    required this.scoreboard,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text('History'),
        ),
        const Divider(height: 20),
        const SizedBox(height: 5),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: scoreboard.history.isEmpty
                  ? _noHistory()
                  : ListView.builder(
                      itemCount: scoreboard.history.length,
                      itemBuilder: (context, index) {
                        return HistoryItem(winner: scoreboard.history[index]);
                      },
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _noHistory() => Padding(
        padding: const EdgeInsets.all(1.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'No game history yet, start playing!',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      );
}
