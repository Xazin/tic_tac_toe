import 'package:flutter/material.dart';

class ScreenBreakpoints {
  static double desktop = 750;
  static double tablet = 500;
  static double mobile = 300;
}

enum ScreenType { mobile, tablet, desktop }

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ScreenType type) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return builder(context, _fromContext(context));
  }

  ScreenType _fromContext(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width > ScreenBreakpoints.desktop) {
      return ScreenType.desktop;
    }

    if (width > ScreenBreakpoints.tablet) {
      return ScreenType.tablet;
    }

    return ScreenType.mobile;
  }
}
