import 'package:flutter/material.dart';
import 'package:wasly/controllers/services/store/store_service.dart';
import 'package:wasly/models/store.dart';
import 'package:wasly_template/wasly_template.dart';

class NearbyStoresWidget extends StatelessWidget {
  final double latitude;
  final double longitude;

  NearbyStoresWidget({
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    final storeService = StoreService();

    return FutureBuilder<List<Store>>(
      future: storeService.getNearbyStores(latitude, longitude),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Failed to load stores',
              style: CustomResponsiveTextStyles.headingH10.copyWith(
                color: Colors.red,
              ),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No nearby stores found.',
              style: CustomResponsiveTextStyles.headingH10.copyWith(
                color: Colors.grey,
              ),
            ),
          );
        } else {
          final stores = snapshot.data!;

          return Container(
            width: double.infinity,
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stores.length,
              itemBuilder: (context, index) {
                final store = stores[index];
                return Row(
                  children: [
                    SmallCardContainer(
                      imagePath: store.photo ??
                          AppConstants.getMockUpPath("product_image.png"),
                      name: store.name.toUpperCase(),
                    ),
                    if (index < stores.length - 1) // Add space between items
                      const SizedBox(width: 16.0),
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }
}
