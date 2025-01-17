import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wasly/controllers/nav_controller.dart';
import 'package:wasly/controllers/services/cart/cart_service.dart';
import 'package:wasly/core/constant_widgets/navigation_bar.dart';
import 'package:wasly/models/cart_product.dart';
import 'package:wasly/screens/payment/payment_screen.dart';
import 'package:wasly/widgets/price_row.dart';
import 'package:wasly_template/core/widgets/Border/custom_outline_input_border.dart';
import 'package:wasly_template/wasly_template.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.find<NavController>();
  final CartService _cartService = CartService();
  late Future<Map<String, dynamic>> _cartData;

  @override
  void initState() {
    super.initState();
    _cartData = _cartService.getCartProducts();
  }

  void _removeProduct(int productId) async {
    try {
      await _cartService.removeFromCart(productId);
      setState(() {
        _cartData = _cartService.getCartProducts();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product removed from cart successfully.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  void _clearCart() async {
    try {
      await _cartService.clearCart();
      setState(() {
        _cartData = _cartService.getCartProducts();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cart cleared successfully.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: CustomResponsiveTextStyles.buttonText1.copyWith(
            color: AppColors.textPrimaryBase,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SvgPicture.asset(
              AppConstants.getCustomerBottomNavigationBarIcons(
                "cart_active.svg",
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => CustomBottomNavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onTap: controller.updateIndex,
          items: bottomNavItems,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, right: 16.0, left: 16.0),
          child: FutureBuilder<Map<String, dynamic>>(
            future: _cartData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error: ${snapshot.error}",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else if (!snapshot.hasData ||
                  snapshot.data!['products'].isEmpty) {
                return Center(
                  child: Text(
                    "Your cart is empty.",
                    style: CustomResponsiveTextStyles.headingH7,
                  ),
                );
              } else {
                final products =
                    snapshot.data!['products'] as List<CartProduct>;
                final total = snapshot.data!['total'];

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CartItemsList(
                        products: products,
                        onRemoveProduct: _removeProduct,
                        onClearCart: _clearCart,
                      ),
                      PromoCodeSection(),
                      PriceRow(
                        label: "Total (${products.length} Items):",
                        value: "\$${total.toStringAsFixed(2)}",
                        isTotal: true,
                      ),
                      Container(
                        width: double.infinity,
                        child: CustomTextButtonActive(
                          text: "Continue",
                          onClick: () {
                            Get.to(() => PaymentScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

// cart_item.dart
class CartItem extends StatelessWidget {
  final String name;
  final double price;
  final int quantity;
  final VoidCallback onRemove;

  const CartItem({
    Key? key,
    required this.name,
    required this.price,
    required this.quantity,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Image.asset(
        AppConstants.getMockUpPath('cart_product_image.png'),
        width: 50,
      ),
      title: Text(
        name,
        style: CustomResponsiveTextStyles.headingH7.copyWith(
          color: AppColors.textPrimaryBase,
        ),
      ),
      subtitle: Text(
        'Price: \$${price.toStringAsFixed(2)} x $quantity',
        style: CustomResponsiveTextStyles.paragraph4.copyWith(
          color: AppColors.textSecondaryBase,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.remove_circle_outline),
        onPressed: onRemove,
      ),
    );
  }
}

// cart_items_list.dart
class CartItemsList extends StatelessWidget {
  final List<CartProduct> products;
  final Function(int productId) onRemoveProduct;
  final VoidCallback onClearCart;

  const CartItemsList({
    Key? key,
    required this.products,
    required this.onRemoveProduct,
    required this.onClearCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${products.length} ITEM(S) IN THE CART',
                style: CustomResponsiveTextStyles.paragraph4.copyWith(
                  color: AppColors.textSecondaryBase,
                ),
              ),
              TextButton(
                onPressed: onClearCart,
                child: Text(
                  'Remove All',
                  style: CustomResponsiveTextStyles.paragraph4.copyWith(
                    color: AppColors.errorBase,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return CartItem(
              name: product.product.name,
              price: product.product.price,
              quantity: product.count,
              onRemove: () => onRemoveProduct(product.product.id),
            );
          },
        ),
      ],
    );
  }
}

// promo_code_section.dart
class PromoCodeSection extends StatelessWidget {
  const PromoCodeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: CustomTextField(
          hintText: "Promo Code",
          defaultIcon: AppConstants.getTextFieldPath("coupon.svg"),
          focusedIcon: AppConstants.getTextFieldPath("coupon.svg"),
          border: BorderRadius.circular(100),
        ));
  }
}

// cart_summary.dart
