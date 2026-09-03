import 'package:flutter/material.dart';

/// Displays a food image from assets, falling back to a styled gradient
/// container with an icon when no image path is provided.
class FoodImage extends StatelessWidget {
  final String imagePath;
  final String iconCode;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const FoodImage({
    super.key,
    required this.imagePath,
    required this.iconCode,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  static IconData iconForCode(String code) {
    switch (code) {
      case 'pizza':
        return Icons.local_pizza_rounded;
      case 'burger':
        return Icons.lunch_dining_rounded;
      case 'indian':
        return Icons.rice_bowl_rounded;
      case 'chinese':
        return Icons.ramen_dining_rounded;
      case 'dessert':
        return Icons.cake_rounded;
      case 'beverage':
        return Icons.local_cafe_rounded;
      default:
        return Icons.restaurant_rounded;
    }
  }

  static List<Color> _gradientForCode(String code) {
    switch (code) {
      case 'pizza':
        return [const Color(0xFFFF8A65), const Color(0xFFE65100)];
      case 'burger':
        return [const Color(0xFFFFCA28), const Color(0xFFF9A825)];
      case 'indian':
        return [const Color(0xFF66BB6A), const Color(0xFF2E7D32)];
      case 'chinese':
        return [const Color(0xFFEF5350), const Color(0xFFC62828)];
      case 'dessert':
        return [const Color(0xFFF48FB1), const Color(0xFFAD1457)];
      case 'beverage':
        return [const Color(0xFF8D6E63), const Color(0xFF4E342E)];
      default:
        return [const Color(0xFFFF8A65), const Color(0xFFE65100)];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (imagePath.isNotEmpty) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Image.asset(
          imagePath,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (_, _, _) => _buildFallback(),
        ),
      );
    }
    return _buildFallback();
  }

  Widget _buildFallback() {
    final colors = _gradientForCode(iconCode);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          colors: [colors[0].withValues(alpha: 0.25), colors[1].withValues(alpha: 0.15)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          iconForCode(iconCode),
          size: (height ?? 80) * 0.45,
          color: colors[1].withValues(alpha: 0.7),
        ),
      ),
    );
  }
}
