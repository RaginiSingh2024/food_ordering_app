import 'package:flutter/material.dart';
import '../main.dart';
import '../models/food_item.dart';
import '../widgets/food_card.dart';
import 'food_details_screen.dart';

/// Screen 1 — Premium Home Screen with smooth, uninterrupted sliver scrolling.
class HomeScreen extends StatelessWidget {
  final List<CartItem> cart;
  final void Function(FoodItem food, int qty) onAddToCart;
  final VoidCallback onNavigateToMenu;
  final VoidCallback onNavigateToCart;

  const HomeScreen({
    super.key,
    required this.cart,
    required this.onAddToCart,
    required this.onNavigateToMenu,
    required this.onNavigateToCart,
  });

  int get _cartCount =>
      cart.fold<int>(0, (sum, item) => sum + item.quantity);

  // All food items shown in the Popular Today grid so the user can scroll smoothly
  List<FoodItem> get _popularItems => allFoodItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            // ── Top Sections (Header, Hero, Search, Categories, Section Title) ──
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Header ────────────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, Ragini! 👋',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textMedium,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Good food. Good mood!',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textDark,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                        // Cart icon with badge
                        GestureDetector(
                          onTap: onNavigateToCart,
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Badge(
                              isLabelVisible: _cartCount > 0,
                              label: Text('$_cartCount'),
                              backgroundColor: AppColors.primary,
                              child: const Icon(
                                Icons.shopping_bag_outlined,
                                color: AppColors.textDark,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    // ── Hero Banner ───────────────────────────────────
                    Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE8613C), Color(0xFFFF8A65)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Stack(
                          children: [
                            Positioned(
                              right: -30,
                              top: -30,
                              child: Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withValues(alpha: 0.1),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: -10,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withValues(alpha: 0.08),
                                ),
                              ),
                            ),
                            // Realistic Burger Photograph on Right
                            Positioned(
                              right: -10,
                              top: 0,
                              bottom: 0,
                              child: Image.asset(
                                'assets/images/hero_burger.png',
                                width: 175,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(22),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Craving\nSomething\nDelicious?',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      height: 1.15,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: onNavigateToMenu,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 9,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: const Text(
                                        'Order Now →',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // ── Search Bar ────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
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
                            size: 22,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Search for food, restaurants...',
                            style: TextStyle(
                              color: AppColors.textLight,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 26),

                    // ── Categories ────────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark,
                          ),
                        ),
                        GestureDetector(
                          onTap: onNavigateToMenu,
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 88,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: const [
                          _HomeCategoryCard(
                            icon: Icons.local_pizza_rounded,
                            label: 'Pizza',
                            color: Color(0xFFFF8A65),
                            bgColor: Color(0xFFFFF3E0),
                          ),
                          _HomeCategoryCard(
                            icon: Icons.lunch_dining_rounded,
                            label: 'Burgers',
                            color: Color(0xFFF9A825),
                            bgColor: Color(0xFFFFF9C4),
                          ),
                          _HomeCategoryCard(
                            icon: Icons.rice_bowl_rounded,
                            label: 'Indian',
                            color: Color(0xFF66BB6A),
                            bgColor: Color(0xFFE8F5E9),
                          ),
                          _HomeCategoryCard(
                            icon: Icons.ramen_dining_rounded,
                            label: 'Chinese',
                            color: Color(0xFFEF5350),
                            bgColor: Color(0xFFFFEBEE),
                          ),
                          _HomeCategoryCard(
                            icon: Icons.cake_rounded,
                            label: 'Desserts',
                            color: Color(0xFFEC407A),
                            bgColor: Color(0xFFFCE4EC),
                          ),
                          _HomeCategoryCard(
                            icon: Icons.local_cafe_rounded,
                            label: 'Drinks',
                            color: Color(0xFF8D6E63),
                            bgColor: Color(0xFFEFEBE9),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 26),

                    // ── Popular Today Header ──────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular Today 🔥',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark,
                          ),
                        ),
                        GestureDetector(
                          onTap: onNavigateToMenu,
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
              ),
            ),

            // ── SliverGrid for Popular Today Food Cards ─────────────────
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.68,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final food = _popularItems[index];
                    return FoodCard(
                      food: food,
                      isGridCard: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FoodDetailsScreen(
                              food: food,
                              onAddToCart: onAddToCart,
                            ),
                          ),
                        );
                      },
                      onAddToCart: () {
                        onAddToCart(food, 1);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${food.name} added to cart'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    );
                  },
                  childCount: _popularItems.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Category card for the home screen horizontal scroll.
class _HomeCategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;

  const _HomeCategoryCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textMedium,
            ),
          ),
        ],
      ),
    );
  }
}
