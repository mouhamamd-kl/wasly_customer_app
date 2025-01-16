import 'package:flutter/material.dart';
import 'package:wasly_template/wasly_template.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'All Reviews',
          style: CustomResponsiveTextStyles.headingH9.copyWith(
            color: AppColors.textPrimaryBase,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomerReviewContainer(
              userImagePath: 'assets/images/image.png',
              username: 'Mohammad Bayer Al-Ali',
              review: 'this product is son of bitch',
              reviewDate: '11/1/2025',
              rate: 4,
            ),
          );
        },
      ),
    );
  }
}
