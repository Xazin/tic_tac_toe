import 'package:flutter/material.dart';

import '../../tic_tac_toe_engine.dart';

class TicTacToeBoard extends StatelessWidget {
  final TicTacToeController gameController;

  final Widget playerOne;
  final Widget playerTwo;

  /// Used to provide a style to all tiles
  final TicTacToeStyle? style;

  /// Used to provide a style to each tile depending on
  /// its index
  final TicTacToeStyle? Function(int index)? styleBuilder;

  final Size? size;

  final ScrollPhysics? physics;

  const TicTacToeBoard({
    super.key,
    required this.gameController,
    required this.playerOne,
    required this.playerTwo,
    this.style,
    this.styleBuilder,
    this.size,
    this.physics = const NeverScrollableScrollPhysics(),
  }) : assert(
          (style == null && styleBuilder != null) ||
              (style == null && styleBuilder == null) ||
              (styleBuilder == null && style != null),
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size?.height,
      width: size?.width,
      child: GridView.count(
        shrinkWrap: true,
        physics: physics,
        crossAxisCount: gameController.columns,
        children: List.generate(
          gameController.rows * gameController.columns,
          (index) {
            final st = relStyle(index);

            return GestureDetector(
              onTap: () => gameController.makeMove(index),
              child: Container(
                margin: st?.margin,
                padding: st?.padding,
                decoration: _tileDecoration(st),
                child: _currentPlayerWidget(index),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget? _currentPlayerWidget(int index) {
    final player = gameController.state.board[index];

    switch (player) {
      case TicTacToePlayer.playerOne:
        return playerOne;
      case TicTacToePlayer.playerTwo:
        return playerTwo;
      default:
        return null;
    }
  }

  TicTacToeStyle? relStyle(int index) =>
      style ?? (styleBuilder != null ? styleBuilder!.call(index) : null);

  BoxDecoration? _tileDecoration(TicTacToeStyle? st) {
    if (st != null) {
      return st.tileDecoration;
    }

    return const BoxDecoration(color: Colors.white);
  }
}
