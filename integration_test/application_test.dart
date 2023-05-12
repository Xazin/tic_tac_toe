import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:tic_tac_toe_eng/main.dart' as application;
import 'package:tic_tac_toe_engine/tic_tac_toe_engine.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-2-end test', () {
    testWidgets('player one win', (tester) async {
      application.main();
      await tester.pumpAndSettle();

      expect(find.text('0'), findsNWidgets(4));

      final tiles = tester.widgetList(find.byType(GameTile)).toList();

      /// Board after moves:
      /// X O O
      /// 0 X 0
      /// 0 0 X
      await tester.tap(find.byWidget(tiles[0]));
      await tester.tap(find.byWidget(tiles[1]));
      await tester.tap(find.byWidget(tiles[4]));
      await tester.tap(find.byWidget(tiles[2]));
      await tester.tap(find.byWidget(tiles[8]));

      await tester.pumpAndSettle();

      /// Total games = 1, Player one wins = 1
      expect(find.text('1'), findsNWidgets(2));
    });

    testWidgets('player two win', (tester) async {
      application.main();
      await tester.pumpAndSettle();

      expect(find.text('0'), findsNWidgets(4));

      final tiles = tester.widgetList(find.byType(GameTile)).toList();

      /// Board after moves:
      /// O O O
      /// X X 0
      /// 0 0 X
      await tester.tap(find.byWidget(tiles[3]));
      await tester.tap(find.byWidget(tiles[0]));
      await tester.tap(find.byWidget(tiles[4]));
      await tester.tap(find.byWidget(tiles[1]));
      await tester.tap(find.byWidget(tiles[8]));
      await tester.tap(find.byWidget(tiles[2]));

      await tester.pumpAndSettle();

      /// Total games = 1, Player two wins = 1
      expect(find.text('1'), findsNWidgets(2));
    });

    testWidgets('draw game and player one win', (tester) async {
      application.main();
      await tester.pumpAndSettle();

      expect(find.text('0'), findsNWidgets(4));

      List<Widget> tiles = tester.widgetList(find.byType(GameTile)).toList();

      /// Board after moves:
      /// O X O
      /// X O X
      /// X O X
      await tester.tap(find.byWidget(tiles[1])); // Player 1
      await tester.tap(find.byWidget(tiles[0])); // Player 2
      await tester.tap(find.byWidget(tiles[3])); // Player 1
      await tester.tap(find.byWidget(tiles[2])); // Player 2
      await tester.tap(find.byWidget(tiles[8])); // Player 1
      await tester.tap(find.byWidget(tiles[4])); // Player 2
      await tester.tap(find.byWidget(tiles[5])); // Player 1
      await tester.tap(find.byWidget(tiles[7])); // Player 2
      await tester.tap(find.byWidget(tiles[6])); // Player 1

      await tester.pumpAndSettle();

      /// Total games = 1, draws= 1
      expect(find.text('1'), findsNWidgets(2));

      tiles = tester.widgetList(find.byType(GameTile)).toList();

      /// Board after moves:
      /// X X X
      /// O O 0
      /// 0 0 0
      await tester.tap(find.byWidget(tiles[0]));
      await tester.tap(find.byWidget(tiles[3]));
      await tester.tap(find.byWidget(tiles[1]));
      await tester.tap(find.byWidget(tiles[4]));
      await tester.tap(find.byWidget(tiles[2]));

      await tester.pumpAndSettle();

      /// Total games = 2, draws= 1, player one wins = 1
      expect(find.text('1'), findsNWidgets(2));
      expect(find.text('2'), findsOneWidget);
    });
  });
}
