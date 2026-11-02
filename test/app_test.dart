import 'package:flutter_test/flutter_test.dart';
import 'package:um_foodloop/src/app.dart';

void main() {
  testWidgets('shows home page and modules', (tester) async {
    await tester.pumpWidget(const FoodLoopApp());
    expect(find.text('UM FoodLoop'), findsOneWidget);
    expect(find.text('Authentication & Roles'), findsOneWidget);
    expect(find.text('Surplus Listings'), findsOneWidget);
  });

  testWidgets('navigates to authentication with safe unconfigured state', (tester) async {
    await tester.pumpWidget(const FoodLoopApp());
    await tester.tap(find.text('Authentication & Roles'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Firebase not configured'), findsOneWidget);
  });
}
