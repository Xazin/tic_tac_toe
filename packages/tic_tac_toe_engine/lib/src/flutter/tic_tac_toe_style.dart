import 'package:flutter/material.dart';

/// Styling for [TicTacToeBoard]
class TicTacToeStyle {
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxDecoration? tileDecoration;

  TicTacToeStyle({this.padding, this.margin, this.tileDecoration});

  /// Used to draw a standard TicTacToe border with
  /// missing outer edges. Should be used in tandem with
  /// [TicTacToeBoard.styleBuilder].
  ///  _/_/_
  /// _/_/_
  /// / /
  ///
  static Border standardBorderFromIndex(int index, [BorderSide? borderSide]) {
    BorderSide? top = borderSide ?? const BorderSide(color: Colors.white),
        left = borderSide ?? const BorderSide(color: Colors.white),
        right = borderSide ?? const BorderSide(color: Colors.white),
        bottom = borderSide ?? const BorderSide(color: Colors.white);

    if (index < 3) {
      // No top
      top = null;
    }

    if (index == 3 || index == 0 || index == 6) {
      // No Left
      left = null;
    }

    if (index == 2 || index == 5 || index == 8) {
      // No right
      right = null;
    }

    if (index > 5) {
      // No bottom
      bottom = null;
    }

    return Border(
      top: top ?? BorderSide.none,
      left: left ?? BorderSide.none,
      right: right ?? BorderSide.none,
      bottom: bottom ?? BorderSide.none,
    );
  }
}
