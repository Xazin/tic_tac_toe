import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

import '../../constants.dart';
import 'widgets/animated_player.dart';

class BoardView extends StatelessWidget {
  final TicTacToeController gameController;
  final bool isSmallView;

  const BoardView({
    super.key,
    required this.gameController,
    this.isSmallView = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Left view / Mobile view
          const SizedBox(height: 50),
          const Text('TicTacToe', style: TextStyle(fontSize: 36)),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: isSmallView ? 350 : 400),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Opacity(
                        opacity: gameController.state.gameEnded ? .7 : 1,
                        child: TicTacToeBoard(
                          styleBuilder:
                              gameController.configuration.isStandardRules
                                  ? (index) => TicTacToeStyle(
                                        tileDecoration: BoxDecoration(
                                          border: TicTacToeStyle
                                              .standardBorderFromIndex(index),
                                        ),
                                      )
                                  : null,
                          style: gameController.configuration.isStandardRules
                              ? null
                              : TicTacToeStyle(
                                  margin: const EdgeInsets.all(2),
                                  tileDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.orange,
                                  ),
                                ),
                          gameController: gameController,
                          playerOne: const AnimatedPlayer(
                            player: TicTacToePlayer.playerOne,
                          ),
                          playerTwo: const AnimatedPlayer(
                            player: TicTacToePlayer.playerTwo,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'Your move',
            style: TextStyle(
              fontSize: isSmallView ? 20 : 24,
            ),
          ),
          SizedBox(height: isSmallView ? 10 : 20),
          Container(
            padding: EdgeInsets.all(isSmallView ? 10 : 14),
            decoration: BoxDecoration(
              color: const Color(0xFF252525),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              currentPlayerAsset,
              width: isSmallView ? 32 : 37,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String get currentPlayerAsset =>
      gameController.state.currentPlayer == TicTacToePlayer.playerOne
          ? kPlayerOneAsset
          : kPlayerTwoAsset;
}
