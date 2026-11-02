import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:um_foodloop/src/app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('home page opens module routes and navigates back', (tester) async {
    await tester.pumpWidget(const FoodLoopApp());

    expect(find.text('UM FoodLoop'), findsOneWidget);
    expect(find.text('Authentication & Roles'), findsOneWidget);

    await tester.tap(find.text('Authentication & Roles'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Firebase not configured'), findsOneWidget);
    expect(find.text('Authentication & Roles'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Surplus Listings'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Status: Not implemented'), findsOneWidget);
    expect(find.text('Surplus Listings'), findsNWidgets(2));
  });
}
