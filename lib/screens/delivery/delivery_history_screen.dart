import 'package:flutter/material.dart';
import 'package:wasly/widgets/product_delivery_card.dart';
import 'package:wasly_template/wasly_template.dart';

class DeliveryHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery History',
            style: CustomResponsiveTextStyles.buttonText1.copyWith(
              color: AppColors.textPrimaryBase,
            )),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Selector
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextHeading10(
                  text: "Select Date",
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement date picker functionality
                  },
                  icon: const Icon(Icons.calendar_today, size: 16),
                  label: const TextHeading10(
                    text: "1 Oct - 30 Oct",
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Order List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: 4, // Replace with dynamic count from data
              itemBuilder: (context, index) {
                // Replace with dynamic data from API or model
                final order = {
                  "status": index == 0
                      ? "SUCCESS"
                      : index == 1
                          ? "CANCEL"
                          : index == 2
                              ? "REJECTED"
                              : "SUCCESS",
                  "price": "\$43.00",
                  "date": "28 Oct, 02:18 PM",
                  "items": "3 Items",
                  "orderId": "TG-36594",
                };
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ProductDeliveryCard(
                    logoUrl:
                        'https://via.placeholder.com/50', // Replace with logo
                    serviceName: 'SwiftParcel',
                    status: order['status']!,
                    price: order['price']!,
                    date: order['date']!,
                    items: order['items']!,
                    orderId: order['orderId']!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
