/// Data model for a food item in the app.
class FoodItem {
  final int id;
  final String name;
  final String category;
  final String description;
  final double price;
  final double rating;
  final int reviewCount;
  final String imagePath; // local asset path for realistic photography
  final String iconCode;
  final List<String> ingredients;
  final String deliveryTime;
  final bool isVeg;
  final bool isChefSpecial;

  const FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.rating,
    this.reviewCount = 0,
    required this.imagePath,
    required this.iconCode,
    required this.ingredients,
    this.deliveryTime = '30 mins',
    this.isVeg = true,
    this.isChefSpecial = false,
  });
}

/// Represents a food item added to the cart with a quantity.
class CartItem {
  final FoodItem food;
  int quantity;

  CartItem({required this.food, this.quantity = 1});

  double get totalPrice => food.price * quantity;
}

// ---------------------------------------------------------------------------
// Local dummy food data with realistic photography for all 12 items
// ---------------------------------------------------------------------------

const List<String> foodCategories = [
  'All',
  'Pizza',
  'Burgers',
  'Indian',
  'Chinese',
  'Desserts',
  'Beverages',
];

const List<FoodItem> allFoodItems = [
  FoodItem(
    id: 1,
    name: 'Margherita Pizza',
    category: 'Pizza',
    description:
        'A timeless classic with a thin, crispy crust, fresh tomato sauce, mozzarella cheese, and fragrant basil leaves. Baked to perfection in our wood-fired oven.',
    price: 249,
    rating: 4.5,
    reviewCount: 120,
    imagePath: 'assets/images/margherita_pizza.jpg',
    iconCode: 'pizza',
    ingredients: ['Mozzarella', 'Tomato Sauce', 'Basil', 'Olive Oil', 'Dough'],
    deliveryTime: '25 mins',
    isChefSpecial: true,
  ),
  FoodItem(
    id: 2,
    name: 'Cheese Burst Pizza',
    category: 'Pizza',
    description:
        'Loaded with a double layer of melted cheese stuffed inside the crust and generously spread on top with mixed herbs. A cheese lover\'s dream.',
    price: 349,
    rating: 4.7,
    reviewCount: 98,
    imagePath: 'assets/images/cheese_burst_pizza.jpg',
    iconCode: 'pizza',
    ingredients: [
      'Mozzarella',
      'Cheddar',
      'Tomato Sauce',
      'Mixed Herbs',
      'Dough',
    ],
    deliveryTime: '30 mins',
  ),
  FoodItem(
    id: 3,
    name: 'Classic Veg Burger',
    category: 'Burgers',
    description:
        'Crispy vegetable patty layered with fresh lettuce, tomato, onion rings, and creamy mayo in a toasted sesame bun. A satisfying crunch in every bite.',
    price: 199,
    rating: 4.3,
    reviewCount: 85,
    imagePath: 'assets/images/veg_burger.jpg',
    iconCode: 'burger',
    ingredients: [
      'Veg Patty',
      'Lettuce',
      'Tomato',
      'Onion',
      'Mayo',
      'Sesame Bun',
    ],
    deliveryTime: '20 mins',
  ),
  FoodItem(
    id: 4,
    name: 'Spicy Chicken Burger',
    category: 'Burgers',
    description:
        'Juicy chicken patty marinated in fiery spices, topped with jalapeños, cheese slice, and tangy chipotle sauce. Bold flavours, big satisfaction.',
    price: 249,
    rating: 4.4,
    reviewCount: 72,
    imagePath: 'assets/images/spicy_chicken_burger.jpg',
    iconCode: 'burger',
    ingredients: [
      'Chicken Patty',
      'Jalapeños',
      'Cheese',
      'Chipotle Sauce',
      'Bun',
    ],
    deliveryTime: '25 mins',
    isVeg: false,
  ),
  FoodItem(
    id: 5,
    name: 'Paneer Tikka',
    category: 'Indian',
    description:
        'Soft paneer cubes marinated in spiced yogurt and chargrilled to perfection. Served with mint chutney and onion rings. An unforgettable smoky flavour.',
    price: 229,
    rating: 4.6,
    reviewCount: 145,
    imagePath: 'assets/images/paneer_tikka.jpg',
    iconCode: 'indian',
    ingredients: [
      'Paneer',
      'Yogurt',
      'Bell Peppers',
      'Onion',
      'Spices',
      'Mint Chutney',
    ],
    deliveryTime: '25 mins',
    isChefSpecial: true,
  ),
  FoodItem(
    id: 6,
    name: 'Masala Dosa',
    category: 'Indian',
    description:
        'Crispy golden rice-lentil crepe filled with spiced potato masala. Served with coconut chutney and sambar. South Indian comfort food at its finest.',
    price: 149,
    rating: 4.3,
    reviewCount: 110,
    imagePath: 'assets/images/masala_dosa.jpg',
    iconCode: 'indian',
    ingredients: [
      'Rice Batter',
      'Potato',
      'Onion',
      'Mustard Seeds',
      'Coconut Chutney',
      'Sambar',
    ],
    deliveryTime: '20 mins',
  ),
  FoodItem(
    id: 7,
    name: 'Veg Hakka Noodles',
    category: 'Chinese',
    description:
        'Stir-fried noodles tossed with colorful crunchy vegetables, soy sauce, and a hint of chilli oil. Street-style favourite with an irresistible aroma.',
    price: 179,
    rating: 4.1,
    reviewCount: 67,
    imagePath: 'assets/images/hakka_noodles.jpg',
    iconCode: 'chinese',
    ingredients: [
      'Noodles',
      'Cabbage',
      'Carrot',
      'Bell Peppers',
      'Soy Sauce',
      'Chilli Oil',
    ],
    deliveryTime: '20 mins',
  ),
  FoodItem(
    id: 8,
    name: 'Veg Manchurian',
    category: 'Chinese',
    description:
        'Crispy vegetable balls drenched in a tangy, spicy Manchurian gravy. A delightful Indo-Chinese fusion dish that packs a punch.',
    price: 189,
    rating: 4.3,
    reviewCount: 58,
    imagePath: 'assets/images/veg_manchurian.jpg',
    iconCode: 'chinese',
    ingredients: [
      'Mixed Vegetables',
      'Corn Flour',
      'Soy Sauce',
      'Garlic',
      'Spring Onion',
    ],
    deliveryTime: '25 mins',
  ),
  FoodItem(
    id: 9,
    name: 'Chocolate Brownie',
    category: 'Desserts',
    description:
        'Warm, fudgy dark chocolate brownie with a crackly top and gooey centre. Served with a scoop of vanilla ice cream. Pure indulgence.',
    price: 159,
    rating: 4.8,
    reviewCount: 200,
    imagePath: 'assets/images/chocolate_brownie.jpg',
    iconCode: 'dessert',
    ingredients: [
      'Dark Chocolate',
      'Butter',
      'Flour',
      'Sugar',
      'Eggs',
      'Vanilla Ice Cream',
    ],
    deliveryTime: '15 mins',
    isChefSpecial: true,
  ),
  FoodItem(
    id: 10,
    name: 'Gulab Jamun',
    category: 'Desserts',
    description:
        'Soft, golden-fried milk dumplings soaked in warm rose-cardamom flavoured sugar syrup. A classic Indian sweet that melts in your mouth.',
    price: 99,
    rating: 4.5,
    reviewCount: 175,
    imagePath: 'assets/images/gulab_jamun.jpg',
    iconCode: 'dessert',
    ingredients: ['Khoya', 'Flour', 'Sugar', 'Rose Water', 'Cardamom', 'Ghee'],
    deliveryTime: '15 mins',
  ),
  FoodItem(
    id: 11,
    name: 'Cold Coffee',
    category: 'Beverages',
    description:
        'Chilled, creamy blend of strong espresso, milk, and ice cream topped with chocolate shavings. The perfect pick-me-up on any day.',
    price: 149,
    rating: 4.4,
    reviewCount: 92,
    imagePath: 'assets/images/cold_coffee.jpg',
    iconCode: 'beverage',
    ingredients: ['Espresso', 'Milk', 'Ice Cream', 'Sugar', 'Chocolate'],
    deliveryTime: '10 mins',
  ),
  FoodItem(
    id: 12,
    name: 'Mango Shake',
    category: 'Beverages',
    description:
        'Thick and refreshing mango milkshake made with ripe Alphonso mangoes and chilled milk. Summer in a glass!',
    price: 129,
    rating: 4.6,
    reviewCount: 88,
    imagePath: 'assets/images/mango_shake.jpg',
    iconCode: 'beverage',
    ingredients: ['Alphonso Mango', 'Milk', 'Sugar', 'Ice'],
    deliveryTime: '10 mins',
  ),
];
