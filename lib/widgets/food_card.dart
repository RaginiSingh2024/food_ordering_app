import 'package:flutter/material.dart';
import '../main.dart';
import '../models/food_item.dart';
import 'food_image.dart';

/// Premium food card for the home grid and menu list.
class FoodCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;
  final bool isGridCard; // true = compact grid card, false = list card

  const FoodCard({
    super.key,
    required this.food,
    required this.onTap,
    required this.onAddToCart,
    this.isGridCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return isGridCard ? _buildGridCard(context) : _buildListCard(context);
  }

  // ── Compact Grid Card (Home Screen) ─────────────────────────────
  Widget _buildGridCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with heart icon overlay
            Stack(
              children: [
                FoodImage(
                  imagePath: food.imagePath,
                  iconCode: food.iconCode,
                  width: double.infinity,
                  height: 120,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border_rounded,
                      size: 16,
                      color: AppColors.heartColor,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    food.category,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 14,
                                color: AppColors.starColor,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                food.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textMedium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '₹${food.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      // Orange add button
                      GestureDetector(
                        onTap: onAddToCart,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18,
                          ),
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
    );
  }

  // ── Horizontal List Card (Menu Screen) ──────────────────────────
  Widget _buildListCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Food image thumbnail
            FoodImage(
              imagePath: food.imagePath,
              iconCode: food.iconCode,
              width: 90,
              height: 90,
              borderRadius: BorderRadius.circular(14),
            ),
            const SizedBox(width: 14),

            // Food info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    food.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textLight,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 15,
                        color: AppColors.starColor,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        food.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMedium,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '₹${food.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                      const Spacer(),
                      // Heart icon
                      const Icon(
                        Icons.favorite_border_rounded,
                        size: 18,
                        color: AppColors.textLight,
                      ),
                      const SizedBox(width: 8),
                      // Add button
                      GestureDetector(
                        onTap: onAddToCart,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
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
    );
  }
}
