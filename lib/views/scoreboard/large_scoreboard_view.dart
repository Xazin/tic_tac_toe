import 'package:flutter/material.dart';

class LargeScoreboardView extends StatelessWidget {
  const LargeScoreboardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Color.fromARGB(255, 39, 39, 39)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: const [],
          ),
        ),
      ),
    );
  }
}
