import 'package:flutter/material.dart';
import 'package:wasly_template/core/widgets/text/text_heading_7.dart';
import 'package:wasly_template/core/widgets/text/text_paragraph_4.dart';
import 'package:wasly_template/wasly_template.dart';

class ProductDeliveryCard extends StatelessWidget {
  final String logoUrl;
  final String serviceName;
  final String status;
  final String price;
  final String date;
  final String items;
  final String orderId;
  const ProductDeliveryCard({
    Key? key,
    required this.logoUrl,
    required this.serviceName,
    required this.status,
    required this.price,
    required this.date,
    required this.items,
    required this.orderId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Color(0xFFF5F2FB),
          width: 1,
        ),
      ),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 15,
              children: [
                // Circular gradient avatar
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.blue],
                    ),
                  ),
                ),
                // Order details
                Expanded(
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SwiftParcel',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'SUCCESS',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextParagraph4(text: '28 Oct, 02:18 PM'),
                          TextParagraph4(text: '• 3 items'),
                          TextHeading7(text: "\$43.00"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Id : TG-36594',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                FittedBox(
                  child: CustomTextButtonActive(
                    text: "Re-Order",
                    padding: EdgeInsets.all(16),
                    radius: 50,
                    onClick: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
