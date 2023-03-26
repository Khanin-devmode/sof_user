import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sof_user/features/user_rep/presentation/widgets/user_rep_card.dart';
import 'package:sof_user/features/users_list/presentation/widgets/user_card.dart';
import 'package:sof_user/main.dart' as app;

void main() {
  group(
    'Simple Business Logic App Testing:',
    () {
      testWidgets(
        'Expect initial list load and navigate to detail and expect rep history load',
        (tester) async {
          //starting app
          app.main();
          await tester.pumpAndSettle();

          expect(find.byType(UserCard), findsWidgets);

          final userCard = find.byType(UserCard).first;

          await tester.tap(userCard);
          await tester.pumpAndSettle();

          expect(find.byType(UserRepCard), findsWidgets);
        },
      );

      testWidgets(
        'Without any bookmarked user, tap bookmark, expected bookmarked icon and vice versa.',
        (tester) async {
          app.main();
          await tester.pumpAndSettle();

          // final bookmarkBtn = find.byKey(const ValueKey('bookmark_icon_0'));
          final bookmarkBtn = find.byIcon(Icons.bookmark_outline).first;

          await tester.tap(bookmarkBtn);
          await tester.pumpAndSettle();

          expect(find.byIcon(Icons.bookmark), findsOneWidget);

          await tester.tap(find.byIcon(Icons.bookmark));
          await tester.pumpAndSettle();

          expect(find.byIcon(Icons.bookmark), findsNothing);
        },
      );

      testWidgets(
        'Load more list when scroll to bottom',
        (tester) async {
          app.main();
          await tester.pumpAndSettle();

          final list = find.byType(Scrollable);
          await tester.scrollUntilVisible(
            // loadingWidget,
            find.byKey(const Key('user_card_99')),
            300,
            scrollable: list,
          );
          await tester.pumpAndSettle();

          expect(find.byKey(const Key('user_card_100')), findsOneWidget);
        },
      );
    },
  );
}
