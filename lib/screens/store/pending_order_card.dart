import 'package:flutter/material.dart';
import 'package:wasly_template/core/widgets/text/text_heading_9.dart';
import 'package:wasly_template/core/widgets/text/text_paragraph_4.dart';
import 'package:wasly_template/wasly_template.dart';

class PendingOrderCard extends StatelessWidget {
  final String title;
  final String description;
  final String orderId;
  final double price;
  final int itemCount;
  final String imageUrl;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const PendingOrderCard({
    Key? key,
    required this.title,
    required this.description,
    required this.orderId,
    required this.price,
    this.itemCount = 1,
    this.imageUrl = '',
    this.onAccept,
    this.onReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        spacing: 20,
        children: [
          Row(
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
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 20,
            children: [
              Expanded(
                child: CustomTextButtonActive(
                  text: "Done",
                  onClick: () {},
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 11),
                ),
              ),
              Expanded(
                child: CustomTextButtonActive(
                  text: "Done",
                  onClick: () {},
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 11),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
