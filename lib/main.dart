import 'package:flutter/material.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

import 'layout/layout_utils.dart';
import 'views/board/board_view.dart';
import 'views/scoreboard/large_scoreboard_view.dart';
import 'views/scoreboard/scoreboard_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: GameView(),
      ),
    ),
  );
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
      autoRestartGame: true,
      scoreboard: TicTacToeScoreboard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3F3F3F),
      floatingActionButton: ResponsiveBuilder(
        builder: (context, type) {
          if (type != ScreenType.mobile) {
            return const SizedBox.shrink();
          }

          return FloatingActionButton(
            onPressed: () {
              // TODO(Mathias): Show settings
            },
            backgroundColor: const Color(0xFF252525),
            foregroundColor: Colors.white,
            child: const Icon(
              Icons.settings_outlined,
              size: 32,
            ),
          );
        },
      ),
      body: SafeArea(
        child: TicTacToeBuilder(
          controller: gameController,
          builder: (context, state, scoreboard) {
            return Row(
              children: [
                ResponsiveBuilder(
                  builder: (context, type) {
                    if (type == ScreenType.mobile) {
                      return Flexible(
                        child: BoardView(gameController: gameController),
                      );
                    }

                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: type == ScreenType.tablet ? 350 : 400,
                      child: BoardView(
                        gameController: gameController,
                      ),
                    );
                  },
                ),
                ResponsiveBuilder(
                  builder: (context, type) {
                    if (type == ScreenType.tablet) {
                      return ScoreboardView(
                        scoreboard: gameController.scoreboard,
                      );
                    }

                    if (type == ScreenType.desktop) {
                      return const LargeScoreboardView();
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
