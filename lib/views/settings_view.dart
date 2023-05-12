import 'package:flutter/material.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

/// TODO(Mathias): Refactor and clean up
Future<void> showSettingsDialog(
        BuildContext context, TicTacToeController controller) async =>
    await showDialog(
      context: context,
      builder: (context) => SettingsDialog(controller: controller),
    );

class SettingsDialog extends StatefulWidget {
  final TicTacToeController controller;

  const SettingsDialog({
    super.key,
    required this.controller,
  });

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  late final TicTacToeController controller;
  late bool autoRestartGame;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    autoRestartGame = controller.configuration.autoRestartGame;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 24),
          ),
          const Divider(),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Auto restart game'),
            value: autoRestartGame,
            onChanged: (newValue) {
              if (newValue == null) {
                return;
              }

              controller.updateConfiguration(
                controller.configuration.copyWith(autoRestartGame: newValue),
              );

              if (controller.state.gameEnded && newValue) {
                controller.restartGame();
              }

              setState(() {
                autoRestartGame = newValue;
              });
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('Rows'),
              const SizedBox(width: 10),
              Expanded(
                child: Slider(
                  label: controller.configuration.rows.toString(),
                  divisions: 9,
                  value: controller.configuration.rows.toDouble(),
                  onChanged: (newValue) {
                    final val = newValue.floor();

                    if (val == controller.configuration.rows) {
                      return;
                    }

                    final winCondition =
                        controller.configuration.winCondition > val &&
                                controller.configuration.winCondition >
                                    controller.configuration.rows
                            ? val > controller.configuration.rows
                                ? val
                                : controller.configuration.rows
                            : controller.configuration.winCondition;

                    controller.updateConfiguration(
                      controller.configuration.copyWith(
                        rows: val,
                        winCondition: winCondition,
                      ),
                    );

                    setState(() {});
                  },
                  min: 3,
                  max: 9,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('Columns'),
              const SizedBox(width: 10),
              Expanded(
                child: Slider(
                  label: controller.configuration.columns.toString(),
                  divisions: 9,
                  value: controller.configuration.columns.toDouble(),
                  onChanged: (newValue) {
                    final val = newValue.floor();

                    if (val == controller.configuration.columns) {
                      return;
                    }

                    final winCondition =
                        controller.configuration.winCondition > val &&
                                controller.configuration.winCondition >
                                    controller.configuration.rows
                            ? val > controller.configuration.rows
                                ? val
                                : controller.configuration.rows
                            : controller.configuration.winCondition;

                    controller.updateConfiguration(
                      controller.configuration.copyWith(
                        columns: val,
                        winCondition: winCondition,
                      ),
                    );

                    setState(() {});
                  },
                  min: 3,
                  max: 9,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('Win condition'),
              const SizedBox(width: 10),
              Expanded(
                child: Opacity(
                  opacity: controller.configuration.rows == 3 &&
                          controller.configuration.columns == 3
                      ? 0.5
                      : 1,
                  child: Slider(
                    label: controller.configuration.winCondition.toString(),
                    divisions: 9,
                    value: controller.configuration.winCondition.toDouble(),
                    onChanged: (newValue) {
                      final val = newValue.floor();

                      if (val == controller.configuration.winCondition) {
                        return;
                      }

                      controller.updateConfiguration(
                        controller.configuration.copyWith(winCondition: val),
                      );

                      setState(() {});
                    },
                    min: 3,
                    max: controller.configuration.columns >
                            controller.configuration.rows
                        ? controller.configuration.columns.toDouble()
                        : controller.configuration.rows.toDouble(),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: controller.state.moves > 0
                ? () {
                    setState(() {
                      controller.restartGame();
                    });
                  }
                : null,
            child: const Text(
              'Restart game',
            ),
          ),
        ],
      ),
    );
  }
}
