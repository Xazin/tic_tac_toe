import 'package:flutter/material.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _playerOneAsset = 'assets/player_one.svg';
const _playerTwoAsset = 'assets/player_two.svg';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: GameView(),
      ),
    ),
  );
}

const boardColor = Color(0xFFFF8A00);

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF252525),
        foregroundColor: Colors.white,
        child: const Icon(
          Icons.settings_outlined,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: TicTacToeBuilder(
          controller: gameController,
          builder: (context, state, scoreboard) {
            return Row(
              children: [
                Flexible(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Left view / Mobile view
                        const SizedBox(height: 50),
                        const Text('TicTacToe', style: TextStyle(fontSize: 36)),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Opacity(
                                  opacity:
                                      gameController.state.gameEnded ? .7 : 1,
                                  child: TicTacToeBoard(
                                    styleBuilder: (index) => TicTacToeStyle(
                                      tileDecoration: BoxDecoration(
                                        border: TicTacToeStyle
                                            .standardBorderFromIndex(index),
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
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String get currentPlayerAsset =>
      gameController.state.currentPlayer == TicTacToePlayer.playerOne
          ? _playerOneAsset
          : _playerTwoAsset;
}

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
              ? _playerOneAsset
              : _playerTwoAsset,
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
