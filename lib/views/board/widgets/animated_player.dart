import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

import '../../../constants.dart';

class AnimatedPlayer extends StatefulWidget {
  final TicTacToePlayer player;

  const AnimatedPlayer({super.key, required this.player});

  @override
  State<AnimatedPlayer> createState() => _AnimatedPlayerState();
}

class _AnimatedPlayerState extends State<AnimatedPlayer>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(
          widget.player == TicTacToePlayer.playerOne
              ? kPlayerOneAsset
              : kPlayerTwoAsset,
          width: 37,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
