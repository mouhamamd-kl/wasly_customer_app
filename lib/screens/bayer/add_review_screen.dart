// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:wasly_template/wasly_template.dart';

class AddReviewScreen extends StatelessWidget {
  String wallpaperImagePath;
  String profileImagePath;
  double rate;
  int numberOfRating;
  String storeName;
  String location;
  AddReviewScreen({
    super.key,
    required this.wallpaperImagePath,
    required this.profileImagePath,
    required this.storeName,
    required this.location,
    required this.rate,
    required this.numberOfRating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            StoreProfileContainer(
              wallpaperImagePath: wallpaperImagePath,
              profileImagePath: profileImagePath,
              rate: rate,
              numberOfRating: numberOfRating,
              storeName: storeName,
              location: location,
            ),
            FullRatingContainer(),
            Container(
              height: 126,
              width: 300,
              color: Colors.black,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: CustomTextButtonActive(text: "Submit", onClick: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
