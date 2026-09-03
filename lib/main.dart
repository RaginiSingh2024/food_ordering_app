import 'package:flutter/material.dart';
import 'models/food_item.dart';
import 'screens/home_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/cart_checkout_screen.dart';

void main() {
  runApp(const FoodieApp());
}

// ── Premium Color Palette ────────────────────────────────────────
class AppColors {
  static const primary = Color(0xFFE8613C);       // Rich terracotta orange
  static const primaryDark = Color(0xFFD4502D);
  static const accent = Color(0xFFFFA726);         // Warm amber accent
  static const background = Color(0xFFFFF8F2);     // Warm cream
  static const surface = Color(0xFFFFFFFF);
  static const cardBg = Color(0xFFFFFFFF);
  static const textDark = Color(0xFF2D1810);       // Dark brown
  static const textMedium = Color(0xFF6B5347);     // Medium brown
  static const textLight = Color(0xFF9E8E85);      // Light brown
  static const divider = Color(0xFFF0E6DE);
  static const starColor = Color(0xFFFFB800);
  static const heartColor = Color(0xFFE8613C);
  static const successGreen = Color(0xFF4CAF50);
}

/// Root widget — manages global cart state and bottom navigation.
class FoodieApp extends StatelessWidget {
  const FoodieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: Colors.white,
          surface: AppColors.surface,
          onSurface: AppColors.textDark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textDark,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: AppColors.cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          side: BorderSide.none,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: AppColors.divider),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: AppColors.divider),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          labelStyle: const TextStyle(color: AppColors.textLight),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppColors.textDark,
        ),
      ),
      home: const AppShell(),
    );
  }
}

/// Main shell with BottomNavigationBar wrapping the 4 tabs.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;
  final List<CartItem> _cart = [];

  void _addToCart(FoodItem food, int qty) {
    setState(() {
      final index = _cart.indexWhere((c) => c.food.id == food.id);
      if (index >= 0) {
        _cart[index].quantity += qty;
      } else {
        _cart.add(CartItem(food: food, quantity: qty));
      }
    });
  }

  void _onCartUpdated() => setState(() {});

  int get _cartCount =>
      _cart.fold<int>(0, (sum, item) => sum + item.quantity);

  void _navigateToTab(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        cart: _cart,
        onAddToCart: _addToCart,
        onNavigateToMenu: () => _navigateToTab(1),
        onNavigateToCart: () => _navigateToTab(2),
      ),
      MenuScreen(
        cart: _cart,
        onAddToCart: _addToCart,
        onCartUpdated: _onCartUpdated,
      ),
      CartCheckoutScreen(
        cart: _cart,
        onCartUpdated: _onCartUpdated,
        onNavigateHome: () => _navigateToTab(0),
      ),
      // Profile placeholder
      _buildProfilePlaceholder(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: NavigationBar(
          height: 68,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          indicatorColor: AppColors.primary.withValues(alpha: 0.12),
          selectedIndex: _currentIndex,
          onDestinationSelected: _navigateToTab,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded, color: AppColors.primary),
              label: 'Home',
            ),
            const NavigationDestination(
              icon: Icon(Icons.restaurant_menu_outlined),
              selectedIcon: Icon(Icons.restaurant_menu, color: AppColors.primary),
              label: 'Menu',
            ),
            NavigationDestination(
              icon: Badge(
                isLabelVisible: _cartCount > 0,
                label: Text('$_cartCount'),
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.shopping_bag_outlined),
              ),
              selectedIcon: Badge(
                isLabelVisible: _cartCount > 0,
                label: Text('$_cartCount'),
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.shopping_bag, color: AppColors.primary),
              ),
              label: 'Orders',
            ),
            const NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: AppColors.primary),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePlaceholder() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
              child: const Icon(
                Icons.person,
                size: 48,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ragini',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'ragini@email.com',
              style: TextStyle(color: AppColors.textLight),
            ),
          ],
        ),
      ),
    );
  }
}
