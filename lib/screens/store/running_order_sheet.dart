import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasly_template/core/widgets/text/text_heading_9.dart';
import 'package:wasly_template/core/widgets/text/text_paragraph_4.dart';
import 'package:wasly_template/wasly_template.dart';

class RunningOrdersSheet extends StatelessWidget {
  const RunningOrdersSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const TextHeading9(
            text: '20 Running Order',
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: Get.height * 0.5,
            child: ListView.separated(
              itemCount: 4,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final items = [
                  'Pepperoni pizza',
                  'Chicken pizza',
                  'Samatian Drink',
                  'Lemonade'
                ];
                return _buildOrderItem(
                  title: items[index],
                  description: 'Delicious Pepperoni Pizza',
                  orderId: 'TG-36594',
                  price: 10.00,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem({
    required String title,
    required String description,
    required String orderId,
    required double price,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextHeading9(
                  text: title,
                ),
                TextParagraph4(
                  text: description,
                ),
                TextParagraph4(
                  text: 'Order Id : $orderId',
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '1 Items',
                style: CustomResponsiveTextStyles.paragraph4.copyWith(
                  color: AppColors.successBase,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: CustomResponsiveTextStyles.headingH9,
              ),
              CustomTextButtonActive(
                text: "Done",
                onClick: () {},
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 11),
              )
            ],
          ),
        ],
      ),
    );
  }
}
