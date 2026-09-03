import 'package:flutter/material.dart';
import '../main.dart';
import '../models/food_item.dart';
import 'food_image.dart';

/// Premium cart item tile with image thumbnail, quantity controls, and delete.
class CartItemTile extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.cartItem,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final food = cartItem.food;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
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
      child: Row(
        children: [
          // Food thumbnail
          FoodImage(
            imagePath: food.imagePath,
            iconCode: food.iconCode,
            width: 60,
            height: 60,
            borderRadius: BorderRadius.circular(12),
          ),
          const SizedBox(width: 12),

          // Name + price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${food.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          // Quantity controls
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _QtyButton(
                  icon: Icons.remove,
                  onTap: onDecrement,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '${cartItem.quantity}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                _QtyButton(
                  icon: Icons.add,
                  onTap: onIncrement,
                  isPrimary: true,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Delete
          GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                size: 18,
                color: Colors.red.shade400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _QtyButton({
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isPrimary ? Colors.white : AppColors.textMedium,
        ),
      ),
    );
  }
}
