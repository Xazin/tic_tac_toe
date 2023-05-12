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
        crossAxisCount: gameController.configuration.columns,
        children: List.generate(
          gameController.configuration.rows *
              gameController.configuration.columns,
          (index) {
            final st = relStyle(index);

            return GameTile(
              onTap: () => gameController.makeMove(index),
              style: st,
              child: _currentPlayerWidget(index),
            );
          },
        ),
      ),
    );
  }

  TicTacToeStyle? relStyle(int index) =>
      style ?? (styleBuilder != null ? styleBuilder!.call(index) : null);

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
}

class GameTile extends StatelessWidget {
  final VoidCallback onTap;
  final Widget? child;
  final TicTacToeStyle? style;

  const GameTile({
    super.key,
    this.style,
    required this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: style?.margin,
        padding: style?.padding,
        decoration: _tileDecoration(style),
        child: child,
      ),
    );
  }

  BoxDecoration? _tileDecoration(TicTacToeStyle? st) {
    if (st != null) {
      return st.tileDecoration;
    }

    return const BoxDecoration(color: Colors.white);
  }
}
