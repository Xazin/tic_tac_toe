import 'package:flutter/material.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

import '../layout/layout_utils.dart';
import 'board/board_view.dart';
import 'scoreboard/scoreboard_view.dart';
import 'scoreboard/widgets/scoreboard_boxes.dart';
import 'settings_view.dart';

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
      configuration: TicTacToeConfig(autoRestartGame: true),
      scoreboard: TicTacToeScoreboard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, type) {
        return Scaffold(
          backgroundColor: const Color(0xFF3F3F3F),
          floatingActionButton: type != ScreenType.mobile
              ? const SizedBox.shrink()
              : FloatingActionButton(
                  onPressed: () => showSettingsDialog(context, gameController),
                  backgroundColor: const Color(0xFF252525),
                  foregroundColor: Colors.white,
                  child: const Icon(
                    Icons.settings_outlined,
                    size: 32,
                  ),
                ),
          body: SafeArea(
            child: _wrapInScrollView(
              type: type,
              child: TicTacToeBuilder(
                controller: gameController,
                builder: (context, state, scoreboard) {
                  return Row(
                    children: [
                      if (type == ScreenType.mobile) ...[
                        Flexible(
                          child: Column(
                            children: [
                              BoardView(
                                gameController: gameController,
                                isSmallView: true,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                child: ScoreboardBoxes(
                                  scoreboard: scoreboard,
                                  isSmallView: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: type == ScreenType.tablet ? 350 : 400,
                          child: BoardView(
                            gameController: gameController,
                          ),
                        ),
                      ],
                      if ([ScreenType.tablet, ScreenType.desktop]
                          .contains(type)) ...[
                        ScoreboardView(
                          controller: gameController,
                          includeHistory: type == ScreenType.desktop,
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _wrapInScrollView({
    required ScreenType type,
    required Widget child,
  }) =>
      type == ScreenType.mobile ? SingleChildScrollView(child: child) : child;
}
