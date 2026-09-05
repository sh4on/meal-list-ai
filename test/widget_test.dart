import 'package:flutter_test/flutter_test.dart';
import 'package:mealist_ai/my_app.dart';

void main() {
  testWidgets('App smoke test', (final WidgetTester tester) async {
    // build our app and advance timer beyond splash delay
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byType(MyApp), findsOneWidget);
  });
}
