import 'package:flutter/material.dart';
import '../main.dart';
import '../models/food_item.dart';
import '../widgets/food_card.dart';
import '../widgets/category_chip.dart';
import 'food_details_screen.dart';

/// Screen 2 — Premium Food Menu with category filtering and search.
class MenuScreen extends StatefulWidget {
  final List<CartItem> cart;
  final void Function(FoodItem food, int qty) onAddToCart;
  final VoidCallback onCartUpdated;

  const MenuScreen({
    super.key,
    required this.cart,
    required this.onAddToCart,
    required this.onCartUpdated,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String _selectedCategory = 'All';

  List<FoodItem> get _filteredItems {
    if (_selectedCategory == 'All') return allFoodItems;
    return allFoodItems
        .where((f) => f.category == _selectedCategory)
        .toList();
  }

  // Maps display labels to category names in data
  static const _categoryConfigs = [
    ('All', Icons.grid_view_rounded),
    ('Pizza', Icons.local_pizza_rounded),
    ('Burgers', Icons.lunch_dining_rounded),
    ('Indian', Icons.rice_bowl_rounded),
    ('Chinese', Icons.ramen_dining_rounded),
    ('Desserts', Icons.cake_rounded),
    ('Beverages', Icons.local_cafe_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Food Menu',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Choose your favourite dishes',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Search bar
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 13,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.search_rounded,
                          color: AppColors.textLight,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Search for dishes...',
                          style: TextStyle(
                            color: AppColors.textLight,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Category Filters ────────────────────────────────
            SizedBox(
              height: 46,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _categoryConfigs.length,
                itemBuilder: (context, index) {
                  final (label, icon) = _categoryConfigs[index];
                  // Show 'Drinks' for Beverages in the UI
                  final displayLabel =
                      label == 'Beverages' ? 'Drinks' : label;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CategoryChip(
                      label: displayLabel,
                      icon: icon,
                      isSelected: _selectedCategory == label,
                      onTap: () =>
                          setState(() => _selectedCategory = label),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 14),

            // ── Results count ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${_filteredItems.length} items found',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // ── Food List ───────────────────────────────────────
            Expanded(
              child: _filteredItems.isEmpty
                  ? const SingleChildScrollView(
                      physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.no_food_rounded,
                                size: 64,
                                color: Color(0xFFE0E0E0),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'No items in this category',
                                style: TextStyle(color: Color(0xFFBDBDBD)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 90),
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final food = _filteredItems[index];
                        return FoodCard(
                          food: food,
                          isGridCard: false,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FoodDetailsScreen(
                                  food: food,
                                  onAddToCart: widget.onAddToCart,
                                ),
                              ),
                            );
                          },
                          onAddToCart: () {
                            widget.onAddToCart(food, 1);
                            setState(() {});
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${food.name} added to cart'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
