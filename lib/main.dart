import 'package:flutter/material.dart';

import 'views/game_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const GameView(),
    ),
  );
}
