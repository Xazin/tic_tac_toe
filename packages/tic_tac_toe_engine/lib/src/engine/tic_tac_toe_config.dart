class TicTacToeConfig {
  final int rows;
  final int columns;
  final int winCondition;
  final bool autoRestartGame;

  TicTacToeConfig({
    this.rows = 3,
    this.columns = 3,
    this.winCondition = 3,
    this.autoRestartGame = false,
  });

  bool get isStandardRules => columns == 3 && rows == 3 && winCondition == 3;

  TicTacToeConfig copyWith({
    int? rows,
    int? columns,
    int? winCondition,
    bool? autoRestartGame,
  }) =>
      TicTacToeConfig(
        rows: rows ?? this.rows,
        columns: columns ?? this.columns,
        winCondition: winCondition ?? this.winCondition,
        autoRestartGame: autoRestartGame ?? this.autoRestartGame,
      );
}
