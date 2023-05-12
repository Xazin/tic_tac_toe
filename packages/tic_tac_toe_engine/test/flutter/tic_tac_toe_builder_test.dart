import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

void main() {
  group('TicTacToeBuilder tests', () {
    testWidgets('Rebuild on State change', (tester) async {
      final gameController = TicTacToeController();

      TicTacToeScoreboard? scoreboard;
      TicTacToeState? state;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TicTacToeBuilder(
              controller: gameController,
              builder: (context, st, sc) {
                scoreboard = sc;
                state = st;

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(scoreboard!.totalGames, 0);
      expect(state!.moves, 0);
      expect(state!.gameEnded, false);
      expect(state!.currentPlayer, TicTacToePlayer.playerOne);
      expect(scoreboard!.playerOne, 0);
      expect(scoreboard!.playerTwo, 0);

      gameController.makeMove(0); // Player 1

      expect(state!.currentPlayer, TicTacToePlayer.playerTwo);

      gameController.makeMove(3); // Player 2

      expect(state!.moves, 2);

      gameController.makeMove(1); // Player 1
      gameController.makeMove(7); // Player 2
      gameController.makeMove(2); // Player 1

      expect(state!.gameEnded, true);
      expect(scoreboard!.playerOne, 1);
      expect(scoreboard!.playerTwo, 0);
    });
  });
}
