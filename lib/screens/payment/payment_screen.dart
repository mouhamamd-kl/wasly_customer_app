import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wasly/screens/location/location_picker_screen.dart';
import 'package:wasly/screens/textScreens/order_successfull_screen.dart';
import 'package:wasly/widgets/payment_card.dart';
import 'package:wasly/widgets/price_row.dart';
import 'package:wasly_template/core/widgets/text/text_button_1.dart';
import 'package:wasly_template/core/widgets/text/text_heading_9.dart';
import 'package:wasly_template/core/widgets/text/text_paragraph_4.dart';
import 'package:wasly_template/wasly_template.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedAddress = "Home";
  String selectedPaymentMethod = "Cash On Delivery";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment",
            style: CustomResponsiveTextStyles.buttonText1.copyWith(
              color: AppColors.textPrimaryBase,
            )),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextHeading9(text: "Address"),
                TextButton(
                  onPressed: () {
                    // Navigate to Add New Location Screen
                    Get.to(() => LocationPickerScreen());
                  },
                  child: TextButton1(
                    text: "Add New Location",
                    color: AppColors.primaryBase,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Address Cards
            _buildAddressCard(
              label: "My Home",
              address: "46 Larkrow, Main Street, UK",
              isSelected: selectedAddress == "Home",
              onTap: () => setState(() => selectedAddress = "Home"),
            ),
            const SizedBox(height: 10),
            _buildAddressCard(
              label: "My Office",
              address: "46 Larkrow, Main Street, UK",
              isSelected: selectedAddress == "Office",
              onTap: () => setState(() => selectedAddress = "Office"),
            ),
            const SizedBox(height: 24),
            // Payment Method
            TextHeading9(text: "Payment Method"),
            const SizedBox(height: 16),
            // Visa Card Payment
            PaymentCard(
                icon: AppConstants.getPaymentCardIcons("visa.svg"),
                label: "Master Card",
                description: "**** 5623",
                isSelected: selectedPaymentMethod == "Card",
                hasAddButton: true,
                onTap: () => setState(() => selectedPaymentMethod = "Card")),
            const SizedBox(height: 10),
            // Cash On Delivery Payment
            PaymentCard(
                icon: AppConstants.getPaymentCardIcons("deliveryBike.svg"),
                label: "Cash On Delivery",
                description: "Just need to pay when you get food",
                isSelected: selectedPaymentMethod == "Cash On Delivery",
                hasAddButton: false,
                onTap: () =>
                    setState(() => selectedPaymentMethod = "Cash On Delivery")),
            Spacer(),
            // Total Price Section

            PriceRow(
                label: "Total (3 Items):", value: "\$63.00", isTotal: true),
            Spacer(),
            // Place Order Button
            Container(
              width: double.infinity,
              child: CustomTextButtonActive(
                text: "Place Order",
                onClick: () {
                  Get.offAll(OrderSuccessfullScreen());
                },
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard({
    required String label,
    required String address,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primaryLight : Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          spacing: 16,
          children: [
            // Image.asset(AppConstants.getlo),
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextHeading9(
                    text: label,
                  ),
                  TextParagraph4(
                    text: address,
                  ),
                  // Text(
                  //   address,
                  //   style: TextStyle(color: Colors.grey),
                  // ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: AppColors.primaryBase,
            ),
          ],
        ),
      ),
    );
  }
}
