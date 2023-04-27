import 'package:flutter/material.dart';
import 'package:tic_tac_toe_engine/engine/tic_tac_toe_controller.dart';
import 'package:tic_tac_toe_engine/engine/tic_tac_toe_player.dart';
import 'package:tic_tac_toe_engine/engine/tic_tac_toe_scoreboard.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: GameView(),
    ),
  ));
}

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late final TicTacToeController gameController;

  @override
  void initState() {
    super.initState();
    gameController = TicTacToeController(
      scoreboard: TicTacToeScoreboard(
        history: [
          TicTacToePlayer.none,
          TicTacToePlayer.none,
          TicTacToePlayer.playerOne,
          TicTacToePlayer.playerTwo,
          TicTacToePlayer.playerOne
        ],
      ),
    );

    gameController.state.addListener(() {
      setState(() {});
    });

    gameController.scoreboard.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isLarge = constraints.maxWidth > 420;
      double minHeight = MediaQuery.of(context).size.height * 0.5;
      if (minHeight < 300) minHeight = 300;

      return Column(
        children: [
          const SizedBox(height: 50),
          Expanded(
            flex: 3,
            child: SizedBox(
              width: isLarge ? minHeight : 320,
              height: isLarge ? minHeight : 320,
              child: GridView.builder(
                physics: const ClampingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return Padding(
                    /// TODO: Customize padding
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      /// TODO: Customize margin
                      // margin: const EdgeInsets.all(4),
                      color: Colors.orange.withOpacity(0.8),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Draws: ${gameController.scoreboard.draws}'),
                    Text('PlayerOne: ${gameController.scoreboard.playerOne}'),
                    Text('PlayerTwo: ${gameController.scoreboard.playerTwo}'),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        gameController.makeMove(7);
                      },
                      child: const Text('Draw!'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Player One!'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Player Two!'),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text('Current Player: ${gameController.state.currentPlayer}'),
              ],
            ),
          ),
        ],
      );
    });
  }
}
