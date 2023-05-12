import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

void main() {
  group('Dynamic rules win validator', () {
    test('Horizontal win', () {
      final gameController = TicTacToeController(
        configuration: TicTacToeConfig(rows: 6, columns: 6, winCondition: 4),
      );

      expect(gameController.state.gameEnded, false);
      expect(gameController.state.moves, 0);

      /// Board after moves
      /// O 0 O 0 O 0
      /// 0 X X X X 0
      /// 0 0 0 0 0 0
      /// 0 0 0 0 0 0
      /// 0 0 0 0 0 0
      /// 0 0 0 0 0 0
      gameController.makeMove(7); // Player 1
      gameController.makeMove(0); // Player 2
      gameController.makeMove(8); // Player 1
      gameController.makeMove(1); // Player 2
      gameController.makeMove(9); // Player 1
      gameController.makeMove(2); // Player 2
      gameController.makeMove(10); // Player 1

      expect(gameController.state.gameEnded, true);
      expect(gameController.state.moves, 7);

      expect(gameController.scoreboard.playerOne, 1);
      expect(gameController.scoreboard.playerTwo, 0);

      gameController.restartGame();
      expect(gameController.state.gameEnded, false);
      expect(gameController.state.moves, 0);

      /// Board after moves
      /// X 0 X 0 X 0
      /// 0 X 0 0 0 0
      /// 0 0 0 0 0 0
      /// 0 0 0 0 0 0
      /// 0 0 0 0 0 0
      /// O O O O 0 0
      gameController.makeMove(0); // Player 1
      gameController.makeMove(30); // Player 2
      gameController.makeMove(2); // Player 1
      gameController.makeMove(31); // Player 2
      gameController.makeMove(4); // Player 1
      gameController.makeMove(32); // Player 2
      gameController.makeMove(6); // Player 1
      gameController.makeMove(33); // Player 2

      expect(gameController.state.gameEnded, true);
      expect(gameController.state.moves, 8);

      expect(gameController.scoreboard.playerOne, 1);
      expect(gameController.scoreboard.playerTwo, 1);
    });

    test('Vertical win', () {
      final gameController = TicTacToeController(
        configuration: TicTacToeConfig(rows: 6, columns: 6, winCondition: 4),
      );

      expect(gameController.state.gameEnded, false);
      expect(gameController.state.moves, 0);

      /// Board after moves
      /// O 0 O 0 0 0
      /// 0 0 X 0 0 0
      /// 0 0 X 0 0 0
      /// 0 0 X 0 0 0
      /// 0 0 X 0 0 0
      /// 0 0 O 0 0 0
      gameController.makeMove(8); // Player 1
      gameController.makeMove(0); // Player 2
      gameController.makeMove(14); // Player 1
      gameController.makeMove(2); // Player 2
      gameController.makeMove(20); // Player 1
      gameController.makeMove(32); // Player 2
      gameController.makeMove(26); // Player 1

      expect(gameController.state.gameEnded, true);
      expect(gameController.state.moves, 7);

      expect(gameController.scoreboard.playerOne, 1);
      expect(gameController.scoreboard.playerTwo, 0);

      gameController.restartGame();
      expect(gameController.state.gameEnded, false);
      expect(gameController.state.moves, 0);

      /// Board after moves
      /// X 0 X 0 X 0
      /// 0 X 0 0 0 0
      /// 0 0 0 0 0 O
      /// 0 0 0 0 0 O
      /// 0 0 0 0 0 O
      /// 0 0 0 0 0 O
      gameController.makeMove(0); // Player 1
      gameController.makeMove(17); // Player 2
      gameController.makeMove(2); // Player 1
      gameController.makeMove(23); // Player 2
      gameController.makeMove(4); // Player 1
      gameController.makeMove(29); // Player 2
      gameController.makeMove(6); // Player 1
      gameController.makeMove(35); // Player 2

      expect(gameController.state.gameEnded, true);
      expect(gameController.state.moves, 8);

      expect(gameController.scoreboard.playerOne, 1);
      expect(gameController.scoreboard.playerTwo, 1);
    });

    test('Diagonal win', () {
      final gameController = TicTacToeController(
        configuration: TicTacToeConfig(rows: 6, columns: 6, winCondition: 4),
      );

      expect(gameController.state.gameEnded, false);
      expect(gameController.state.moves, 0);

      /// Board after moves
      /// X O O O 0 0
      /// 0 X 0 0 0 0
      /// 0 0 X 0 0 0
      /// 0 0 0 X 0 0
      /// 0 0 0 0 0 0
      /// 0 0 0 0 0 0
      gameController.makeMove(0); // Player 1
      gameController.makeMove(1); // Player 2
      gameController.makeMove(7); // Player 1
      gameController.makeMove(2); // Player 2
      gameController.makeMove(14); // Player 1
      gameController.makeMove(3); // Player 2
      gameController.makeMove(21); // Player 1

      expect(gameController.state.gameEnded, true);
      expect(gameController.state.moves, 7);

      expect(gameController.scoreboard.playerOne, 1);
      expect(gameController.scoreboard.playerTwo, 0);

      gameController.restartGame();
      expect(gameController.state.gameEnded, false);
      expect(gameController.state.moves, 0);

      /// Board after moves
      /// X O X O X X
      /// 0 0 0 0 0 0
      /// O 0 0 0 0 0
      /// 0 O 0 0 0 0
      /// 0 0 O 0 0 0
      /// 0 0 0 O 0 0
      gameController.makeMove(0); // Player 1
      gameController.makeMove(19); // Player 2
      gameController.makeMove(2); // Player 1
      gameController.makeMove(33); // Player 2
      gameController.makeMove(4); // Player 1
      gameController.makeMove(26); // Player 2
      gameController.makeMove(5); // Player 1
      gameController.makeMove(12); // Player 2

      expect(gameController.state.gameEnded, true);
      expect(gameController.state.moves, 8);

      expect(gameController.scoreboard.playerOne, 1);
      expect(gameController.scoreboard.playerTwo, 1);
    });
  });

  group('Standard rules win validator', () {
    test('Horizontal win', () {
      final gameController = TicTacToeController();

      expect(gameController.state.gameEnded, false);
      expect(gameController.state.moves, 0);

      // Player 1: Row 1
      gameController.makeMove(0); // Player 1
      gameController.makeMove(3); // Player 2
      gameController.makeMove(1); // Player 1
      gameController.makeMove(4); // Player 2
      gameController.makeMove(2); // Player 1

      expect(gameController.state.gameEnded, true);
      expect(gameController.state.moves, 5);

      expect(gameController.scoreboard.playerOne, 1);
      expect(gameController.scoreboard.playerTwo, 0);

      gameController.restartGame();
      expect(gameController.state.gameEnded, false);
      expect(gameController.state.moves, 0);

      // Player 2: Row 2
      gameController.makeMove(0); // Player 1
      gameController.makeMove(3); // Player 2
      gameController.makeMove(7); // Player 1
      gameController.makeMove(4); // Player 2
      gameController.makeMove(8); // Player 1
      gameController.makeMove(5); // Player 2

      expect(gameController.state.gameEnded, true);
      expect(gameController.state.moves, 6);

      expect(gameController.scoreboard.playerOne, 1);
      expect(gameController.scoreboard.playerTwo, 1);

      gameController.restartGame();
      expect(gameController.state.gameEnded, false);
      expect(gameController.state.moves, 0);

      // Player 1: Row 3
      gameController.makeMove(6); // Player 1
      gameController.makeMove(3); // Player 2
      gameController.makeMove(7); // Player 1
      gameController.makeMove(4); // Player 2
      gameController.makeMove(8); // Player 1

      expect(gameController.state.gameEnded, true);
      expect(gameController.state.moves, 5);

      expect(gameController.scoreboard.playerOne, 2);
      expect(gameController.scoreboard.playerTwo, 1);
    });

    test('Vertical win', () {
      final gameController = TicTacToeController();

      expect(gameController.state.gameEnded, false);
      expect(gameController.state.moves, 0);

      // Player 1: Column 1
      gameController.makeMove(0); // Player 1
      gameController.makeMove(1); // Player 2
      gameController.makeMove(3); // Player 1
      gameController.makeMove(4); // Player 2
      gameController.makeMove(6); // Player 1

      expect(gameController.state.gameEnded, true);
      expect(gameController.state.moves, 5);

      expect(gameController.scoreboard.playerOne, 1);
      expect(gameController.scoreboard.playerTwo, 0);

      gameController.restartGame();
      expect(gameController.state.gameEnded, false);
      expect(gameController.state.moves, 0);

      // Player 2: Column 2
      gameController.makeMove(0); // Player 1
      gameController.makeMove(1); // Player 2
      gameController.makeMove(8); // Player 1
      gameController.makeMove(4); // Player 2
      gameController.makeMove(2); // Player 1
      gameController.makeMove(7); // Player 2

      expect(gameController.state.gameEnded, true);
      expect(gameController.state.moves, 6);

      expect(gameController.scoreboard.playerOne, 1);
      expect(gameController.scoreboard.playerTwo, 1);

      gameController.restartGame();
      expect(gameController.state.gameEnded, false);
      expect(gameController.state.moves, 0);

      // Player 1: Column 3
      gameController.makeMove(2); // Player 1
      gameController.makeMove(3); // Player 2
      gameController.makeMove(5); // Player 1
      gameController.makeMove(4); // Player 2
      gameController.makeMove(8); // Player 1

      expect(gameController.state.gameEnded, true);
      expect(gameController.state.moves, 5);

      expect(gameController.scoreboard.playerOne, 2);
      expect(gameController.scoreboard.playerTwo, 1);
    });

    test('Diagonal win', () {
      final gameController = TicTacToeController();

      expect(gameController.state.gameEnded, false);
      expect(gameController.state.moves, 0);

      // Player 1: Top-left to Bottom-right
      gameController.makeMove(0); // Player 1
      gameController.makeMove(1); // Player 2
      gameController.makeMove(4); // Player 1
      gameController.makeMove(2); // Player 2
      gameController.makeMove(8); // Player 1

      expect(gameController.state.gameEnded, true);
      expect(gameController.state.moves, 5);

      expect(gameController.scoreboard.playerOne, 1);
      expect(gameController.scoreboard.playerTwo, 0);

      gameController.restartGame();
      expect(gameController.state.gameEnded, false);
      expect(gameController.state.moves, 0);

      // Player 2: Top-right to Bottom-left
      gameController.makeMove(0); // Player 1
      gameController.makeMove(2); // Player 2
      gameController.makeMove(1); // Player 1
      gameController.makeMove(4); // Player 2
      gameController.makeMove(3); // Player 1
      gameController.makeMove(6); // Player 2

      expect(gameController.state.gameEnded, true);
      expect(gameController.state.moves, 6);

      expect(gameController.scoreboard.playerOne, 1);
      expect(gameController.scoreboard.playerTwo, 1);
    });
  });
}
