import 'package:flutter_test/flutter_test.dart';
import 'package:foodie/main.dart';

void main() {
  testWidgets('App renders home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const FoodieApp());

    // Verify the greeting is displayed
    expect(find.text('Hello, Ragini! 👋'), findsOneWidget);

    // Verify the welcome text is shown
    expect(find.text('Good food. Good mood!'), findsOneWidget);
  });
}
