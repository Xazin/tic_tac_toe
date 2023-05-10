import 'package:flutter/material.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

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
      autoRestartGame: false,
      rows: 6,
      columns: 6,
      winCondition: 4,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TicTacToeBuilder(
          controller: gameController,
          builder: (context, state, scoreboard) {
            return Column(
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 6,
                        children: List.generate(
                          6 * 6,
                          (index) => GestureDetector(
                            onTap: () => gameController.makeMove(index),
                            child: Container(
                              margin: const EdgeInsets.all(1),
                              color: Colors.blue,
                              child: Center(
                                child: Text(
                                  gameController.state.board[index] ==
                                          TicTacToePlayer.playerOne
                                      ? 'X'
                                      : gameController.state.board[index] ==
                                              TicTacToePlayer.playerTwo
                                          ? 'O'
                                          : '',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                TextButton(
                  onPressed: gameController.state.gameEnded
                      ? () => gameController.restartGame()
                      : null,
                  child: const Text('New game'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
