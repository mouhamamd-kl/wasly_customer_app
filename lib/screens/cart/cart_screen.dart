import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wasly/controllers/nav_controller.dart';
import 'package:wasly/core/constant_widgets/navigation_bar.dart';
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
  // Create a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.find<NavController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
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
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                // const CartHeader(),
                // const RestaurantInfo(),
                const CartItemsList(),

                const PromoCodeSection(),

                PriceRow(
                    label: "Total (3 Items):", value: "\$63.00", isTotal: true),

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

  const CartItem({
    Key? key,
    required this.name,
    required this.price,
    required this.quantity,
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
        'Price: \$${price.toStringAsFixed(2)} * 2',
        style: CustomResponsiveTextStyles.paragraph4.copyWith(
          color: AppColors.textSecondaryBase,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () {},
          ),
          Text(
            '$quantity',
            style: CustomResponsiveTextStyles.paragraph4.copyWith(
              color: AppColors.textPrimaryBase,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle, color: Colors.purple),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// cart_items_list.dart
class CartItemsList extends StatelessWidget {
  const CartItemsList({Key? key}) : super(key: key);

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
                '3 ITEM IN THE CART',
                style: CustomResponsiveTextStyles.paragraph4.copyWith(
                  color: AppColors.textSecondaryBase,
                ),
              ),
              TextButton(
                onPressed: () {},
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
          itemCount: 30,
          itemBuilder: (context, index) {
            return const CartItem(
              name: 'Nothing Ear',
              price: 10.00,
              quantity: 2,
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
