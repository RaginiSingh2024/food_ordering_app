import 'package:flutter/material.dart';
import '../main.dart';
import '../models/food_item.dart';
import '../widgets/cart_item_tile.dart';

/// Screen 4 — Premium Cart & Checkout Screen
class CartCheckoutScreen extends StatefulWidget {
  final List<CartItem> cart;
  final VoidCallback onCartUpdated;
  final VoidCallback? onNavigateHome;

  const CartCheckoutScreen({
    super.key,
    required this.cart,
    required this.onCartUpdated,
    this.onNavigateHome,
  });

  @override
  State<CartCheckoutScreen> createState() => _CartCheckoutScreenState();
}

class _CartCheckoutScreenState extends State<CartCheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController(text: 'Ragini');
  final _phoneController = TextEditingController(text: '9876543210');
  final _addressController =
      TextEditingController(text: '221B Baker Street, Flat 4A');
  String? _selectedPayment = 'UPI';
  bool _saveAddress = true;

  static const double _deliveryFee = 40;

  double get _subtotal =>
      widget.cart.fold<double>(0, (sum, item) => sum + item.totalPrice);

  double get _grandTotal => _subtotal > 0 ? _subtotal + _deliveryFee : 0;

  int get _totalCount =>
      widget.cart.fold<int>(0, (sum, item) => sum + item.quantity);

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _clearCart() {
    if (widget.cart.isEmpty) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Clear Cart?',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),
        content: const Text(
          'Are you sure you want to remove all items from your cart?',
          style: TextStyle(color: AppColors.textMedium),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textLight)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => widget.cart.clear());
              widget.onCartUpdated();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cart cleared'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _placeOrder() {
    if (widget.cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add items to your cart first')),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedPayment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a payment method')),
      );
      return;
    }

    final orderId =
        'FOD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    final totalAmountFormatted = '₹${_grandTotal.toStringAsFixed(0)}';
    final paymentMethod = _selectedPayment!;
    final recipient = _nameController.text.trim();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Celebratory icon
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('🎉', style: TextStyle(fontSize: 36)),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Order Confirmed!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Your order has been placed successfully.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textMedium,
              ),
            ),
            const SizedBox(height: 20),

            // Order details card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                children: [
                  _dialogRow('Order ID', orderId, isHighlight: true),
                  const Divider(height: 16, color: AppColors.divider),
                  _dialogRow('Deliver To', recipient),
                  const SizedBox(height: 6),
                  _dialogRow('Items', '$_totalCount items'),
                  const SizedBox(height: 6),
                  _dialogRow('Payment', paymentMethod),
                  const Divider(height: 16, color: AppColors.divider),
                  _dialogRow('Total Amount', totalAmountFormatted, isBold: true),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // Done button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx); // Close dialog
                  setState(() {
                    widget.cart.clear();
                  });
                  widget.onCartUpdated();

                  // Navigate back to Home
                  if (widget.onNavigateHome != null) {
                    widget.onNavigateHome!();
                  } else if (Navigator.canPop(context)) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('🎉 Thank you for your order! Enjoy your meal.'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dialogRow(String label, String value,
      {bool isBold = false, bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: AppColors.textMedium,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 15 : 13,
            fontWeight: isBold || isHighlight ? FontWeight.w800 : FontWeight.w600,
            color: isHighlight
                ? AppColors.primary
                : (isBold ? AppColors.textDark : AppColors.textDark),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasItems = widget.cart.isNotEmpty;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (Navigator.canPop(context)) ...[
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: AppColors.textDark,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                      ],
                      const Text(
                        'Your Cart',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                  if (hasItems)
                    TextButton(
                      onPressed: _clearCart,
                      child: const Text(
                        'Clear All',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ── Body ─────────────────────────────────────────────
            Expanded(
              child: hasItems
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 110),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Cart Items ───────────────────────────
                          ...widget.cart.map(
                            (item) => CartItemTile(
                              cartItem: item,
                              onIncrement: () {
                                setState(() => item.quantity++);
                                widget.onCartUpdated();
                              },
                              onDecrement: () {
                                if (item.quantity > 1) {
                                  setState(() => item.quantity--);
                                  widget.onCartUpdated();
                                }
                              },
                              onRemove: () {
                                setState(() => widget.cart.remove(item));
                                widget.onCartUpdated();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${item.food.name} removed from cart',
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 24),

                          // ── Delivery Details ─────────────────────
                          const Row(
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: AppColors.primary,
                                size: 22,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Delivery Details',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Full Name
                                  TextFormField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      labelText: 'Full Name',
                                      prefixIcon: const Icon(
                                        Icons.person_outline_rounded,
                                        color: AppColors.textLight,
                                        size: 20,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Please enter your full name';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 14),

                                  // Phone Number
                                  TextFormField(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      prefixIcon: const Icon(
                                        Icons.phone_outlined,
                                        color: AppColors.textLight,
                                        size: 20,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Please enter your phone number';
                                      }
                                      if (value.trim().length < 10) {
                                        return 'Phone number must be at least 10 digits';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 14),

                                  // Delivery Address
                                  TextFormField(
                                    controller: _addressController,
                                    maxLines: 2,
                                    decoration: InputDecoration(
                                      labelText: 'Delivery Address',
                                      alignLabelWithHint: true,
                                      prefixIcon: const Padding(
                                        padding: EdgeInsets.only(bottom: 24),
                                        child: Icon(
                                          Icons.home_outlined,
                                          color: AppColors.textLight,
                                          size: 20,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Please enter your delivery address';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  // Payment dropdown
                                  DropdownButtonFormField<String>(
                                    initialValue: _selectedPayment,
                                    decoration: InputDecoration(
                                      labelText: 'Select Payment Method',
                                      prefixIcon: const Icon(
                                        Icons.payment_rounded,
                                        color: AppColors.textLight,
                                        size: 20,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'Cash on Delivery',
                                        child: Text('Cash on Delivery (COD)'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'UPI',
                                        child: Text('UPI (Google Pay, PhonePe)'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Credit/Debit Card',
                                        child: Text('Credit / Debit Card'),
                                      ),
                                    ],
                                    onChanged: (val) {
                                      setState(() => _selectedPayment = val);
                                    },
                                    validator: (val) {
                                      if (val == null) {
                                        return 'Please choose a payment method';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 8),

                                  // Checkbox
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _saveAddress,
                                        activeColor: AppColors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        onChanged: (val) => setState(
                                            () => _saveAddress = val ?? false),
                                      ),
                                      const Text(
                                        'Save this address for next time',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.textMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // ── Order Summary ────────────────────────
                          const Row(
                            children: [
                              Icon(
                                Icons.receipt_long_rounded,
                                color: AppColors.primary,
                                size: 22,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Order Summary',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                _summaryRow(
                                  'Subtotal',
                                  '₹${_subtotal.toStringAsFixed(0)}',
                                ),
                                const SizedBox(height: 10),
                                _summaryRow(
                                  'Delivery Fee',
                                  '₹${_deliveryFee.toStringAsFixed(0)}',
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Divider(color: AppColors.divider),
                                ),
                                _summaryRow(
                                  'Total Amount',
                                  '₹${_grandTotal.toStringAsFixed(0)}',
                                  isTotal: true,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 26),

                          // ── Place Order Button ───────────────────
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _placeOrder,
                              icon: const Icon(Icons.check_circle_outline_rounded,
                                  size: 22),
                              label: Text(
                                'Place Order  •  ₹${_grandTotal.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : _buildEmptyState(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String title, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w500,
            color: isTotal ? AppColors.textDark : AppColors.textMedium,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
            color: isTotal ? AppColors.primary : AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  size: 48,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Your cart is empty',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Explore our menu and add your favorite dishes to place an order.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textMedium,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  if (widget.onNavigateHome != null) {
                    widget.onNavigateHome!();
                  } else if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.restaurant_menu_rounded, size: 20),
                label: const Text('Browse Menu'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
