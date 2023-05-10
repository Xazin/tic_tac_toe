import 'package:flutter/material.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

typedef TicTacToeWidgetBuilder = Widget Function(
  BuildContext context,
  TicTacToeState state,
  TicTacToeScoreboard scoreboard,
);

/// [TicTacToeBuilder] takes care of rebuilds when actions
/// performed through the [controller] modifies the state
/// of the game.
///
/// This only looks at changes in the game state, and thus
/// only rebuilds if a move was made. Manual updates to the
/// scoreboard will not trigger an update.
///
class TicTacToeBuilder extends StatefulWidget {
  final TicTacToeController controller;
  final TicTacToeWidgetBuilder builder;

  const TicTacToeBuilder({
    super.key,
    required this.controller,
    required this.builder,
  });

  @override
  State<TicTacToeBuilder> createState() => _TicTacToeBuilderState();
}

class _TicTacToeBuilderState extends State<TicTacToeBuilder> {
  late final TicTacToeController _controller;
  late TicTacToeScoreboard _scoreboard;
  late TicTacToeState _state;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _scoreboard = _controller.scoreboard;
    _state = _controller.state;

    _state.addListener(_update);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _state,
      _scoreboard,
    );
  }

  @override
  void dispose() {
    _state.removeListener(_update);
    super.dispose();
  }

  void _update() {
    if (!mounted) {
      return;
    }

    _scoreboard = _controller.scoreboard;
    _state = _controller.state;

    setState(() {});
  }
}
