import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasly/screens/store/pending_order_card.dart';
import 'package:wasly_template/core/widgets/text/text_heading_9.dart';
import 'package:wasly_template/core/widgets/text/text_paragraph_4.dart';
import 'package:wasly_template/wasly_template.dart';

class PendingOrderSheet extends StatelessWidget {
  const PendingOrderSheet({Key? key}) : super(key: key);

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
                return PendingOrderCard(
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
}
