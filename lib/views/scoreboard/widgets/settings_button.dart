import 'package:flutter/material.dart';
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

import '../../settings_view.dart';

class SettingsButton extends StatelessWidget {
  final TicTacToeController controller;

  const SettingsButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => showSettingsDialog(context, controller),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Settings'),
                const SizedBox(width: 10),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFF3F3F3F),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.settings_outlined,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
