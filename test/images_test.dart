import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodie/main.dart';
import 'package:foodie/models/food_item.dart';
import 'package:foodie/widgets/category_chip.dart';

void main() {
  testWidgets('Every food item has a valid non-empty imagePath',
      (WidgetTester tester) async {
    for (final food in allFoodItems) {
      expect(food.imagePath, isNotEmpty,
          reason: '${food.name} must have an imagePath');
      expect(food.imagePath.startsWith('assets/images/'), isTrue,
          reason: '${food.name} imagePath must be in assets/images/');
    }
  });

  testWidgets('App renders all food items in menu without errors',
      (WidgetTester tester) async {
    await tester.pumpWidget(const FoodieApp());

    // Switch to Menu tab
    await tester.tap(find.byIcon(Icons.restaurant_menu_outlined));
    await tester.pumpAndSettle();

    // Verify Menu Screen is shown
    expect(find.text('Food Menu'), findsOneWidget);

    // Filter by Chinese
    final chineseChip = find.widgetWithText(CategoryChip, 'Chinese');
    expect(chineseChip, findsOneWidget);
    await tester.tap(chineseChip);
    await tester.pumpAndSettle();
    expect(find.text('Veg Hakka Noodles'), findsOneWidget);
    expect(find.text('Veg Manchurian'), findsOneWidget);

    // Scroll category row to reveal Desserts and Drinks
    final categoryList = find.byType(ListView).first;
    await tester.drag(categoryList, const Offset(-300, 0));
    await tester.pumpAndSettle();

    // Filter by Desserts
    final dessertsChip = find.widgetWithText(CategoryChip, 'Desserts');
    expect(dessertsChip, findsOneWidget);
    await tester.tap(dessertsChip);
    await tester.pumpAndSettle();
    expect(find.text('Chocolate Brownie'), findsOneWidget);
    expect(find.text('Gulab Jamun'), findsOneWidget);

    // Filter by Drinks
    final drinksChip = find.widgetWithText(CategoryChip, 'Drinks');
    expect(drinksChip, findsOneWidget);
    await tester.tap(drinksChip);
    await tester.pumpAndSettle();
    expect(find.text('Cold Coffee'), findsOneWidget);
    expect(find.text('Mango Shake'), findsOneWidget);
  });
}
