import 'package:flutter/material.dart';
import '../main.dart';
import '../models/food_item.dart';
import '../widgets/food_image.dart';

/// Screen 3 — Premium Food Details with large image, info, ingredients, and quantity.
class FoodDetailsScreen extends StatefulWidget {
  final FoodItem food;
  final void Function(FoodItem food, int qty) onAddToCart;

  const FoodDetailsScreen({
    super.key,
    required this.food,
    required this.onAddToCart,
  });

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int _quantity = 1;
  bool _isFavourite = false;

  double get _total => widget.food.price * _quantity;

  @override
  Widget build(BuildContext context) {
    final food = widget.food;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Scrollable Content ──────────────────────────────────
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: EdgeInsets.only(bottom: 120 + bottomPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Hero Image ────────────────────────────────────
                FoodImage(
                  imagePath: food.imagePath,
                  iconCode: food.iconCode,
                  width: double.infinity,
                  height: 300,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(28),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Name & Category ────────────────────────
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textDark,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    food.category,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Price
                          Text(
                            '₹${food.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // ── Rating ─────────────────────────────────
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 20,
                            color: AppColors.starColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            food.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '(${food.reviewCount} reviews)',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textLight,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ── Feature Cards ──────────────────────────
                      Row(
                        children: [
                          _FeatureChip(
                            icon: Icons.access_time_rounded,
                            label: food.deliveryTime,
                            subtitle: 'Delivery',
                          ),
                          const SizedBox(width: 10),
                          _FeatureChip(
                            icon: food.isVeg
                                ? Icons.eco_rounded
                                : Icons.restaurant_rounded,
                            label: food.isVeg ? 'Pure Veg' : 'Non-Veg',
                            subtitle: '',
                          ),
                          const SizedBox(width: 10),
                          if (food.isChefSpecial)
                            const _FeatureChip(
                              icon: Icons.workspace_premium_rounded,
                              label: "Chef's",
                              subtitle: 'Special',
                            ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ── Description ────────────────────────────
                      const Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        food.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textMedium,
                          height: 1.55,
                        ),
                      ),

                      const SizedBox(height: 22),

                      // ── Ingredients ────────────────────────────
                      const Text(
                        'Ingredients',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: food.ingredients.map((ing) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.divider),
                            ),
                            child: Text(
                              ing,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textMedium,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 24),

                      // ── Quantity Selector ──────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Quantity',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: AppColors.divider),
                            ),
                            child: Row(
                              children: [
                                _QtyControl(
                                  icon: Icons.remove,
                                  onTap: () {
                                    if (_quantity > 1) {
                                      setState(() => _quantity--);
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                  ),
                                  child: Text(
                                    '$_quantity',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                ),
                                _QtyControl(
                                  icon: Icons.add,
                                  isPrimary: true,
                                  onTap: () => setState(() => _quantity++),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ── Pinned Top Navigation Buttons ──────────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            child: _CircleButton(
              icon: Icons.arrow_back_rounded,
              onTap: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 16,
            child: _CircleButton(
              icon: _isFavourite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: _isFavourite ? AppColors.heartColor : null,
              onTap: () =>
                  setState(() => _isFavourite = !_isFavourite),
            ),
          ),

          // ── Sticky Bottom Bar ──────────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(22, 16, 22, 16 + bottomPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Total price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Total Price',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textLight,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '₹${_total.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  // Add to Cart button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        widget.onAddToCart(food, _quantity);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${food.name} × $_quantity added to cart',
                            ),
                            duration: const Duration(seconds: 2),
                            action: SnackBarAction(
                              label: 'View Cart',
                              textColor: Colors.white,
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart_rounded, size: 20),
                      label: const Text('Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Helper Widgets ────────────────────────────────────────────────

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const _CircleButton({
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 22, color: color ?? AppColors.textDark),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;

  const _FeatureChip({
    required this.icon,
    required this.label,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Icon(icon, size: 22, color: AppColors.primary),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.textLight,
              ),
            ),
        ],
      ),
    );
  }
}

class _QtyControl extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _QtyControl({
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isPrimary ? Colors.white : AppColors.textMedium,
        ),
      ),
    );
  }
}
