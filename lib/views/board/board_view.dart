import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

import '../../constants.dart';
import 'widgets/animated_player.dart';

class BoardView extends StatelessWidget {
  const BoardView({
    super.key,
    required this.gameController,
  });

  final TicTacToeController gameController;

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
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40.0,
                      ),
                      child: Opacity(
                        opacity: gameController.state.gameEnded ? .7 : 1,
                        child: TicTacToeBoard(
                          styleBuilder: (index) => TicTacToeStyle(
                            tileDecoration: BoxDecoration(
                              border:
                                  TicTacToeStyle.standardBorderFromIndex(index),
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
          const Text(
            'Your move',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF252525),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              currentPlayerAsset,
              width: 37,
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
