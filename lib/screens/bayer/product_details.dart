// ignore_for_file: must_be_immutable

import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:wasly_template/wasly_template.dart';

class ProductDetails extends StatefulWidget {
  bool isExpanded = false;
  String imagePath;
  String productName;
  String storeName;
  double productRate;
  int ratingNumber;
  double productPrice;
  String productDiscription;

  ProductDetails({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.storeName,
    required this.productRate,
    required this.ratingNumber,
    required this.productPrice,
    required this.productDiscription,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    double screenHieght = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            ProfileWallpaper(wallpaperImagePath: widget.imagePath),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                spacing: 20,
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Text(
                            widget.productName,
                            style:
                                CustomResponsiveTextStyles.headingH5.copyWith(
                              color: AppColors.textPrimaryBase,
                            ),
                          ),
                          Text(
                            'From ${widget.storeName}',
                            style:
                                CustomResponsiveTextStyles.paragraph1.copyWith(
                              color: AppColors.textSecondaryBase,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      RatingcontainerLight(
                        rate: widget.productRate,
                        numberOfRating: widget.ratingNumber,
                        backgroundOpacity: 0,
                      ),
                      GestureDetector(
                        child: Text(
                          'see all reviews',
                          style:
                              CustomResponsiveTextStyles.buttonText5.copyWith(
                            color: AppColors.primaryBase,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 5,
                    children: [
                      Text(
                        "\$${widget.productPrice}",
                        style: CustomResponsiveTextStyles.headingH3.copyWith(
                          color: AppColors.textPrimaryBase,
                        ),
                      ),
                      Spacer(),
                      CounterWidget(),
                    ],
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: screenHieght * 0.15,
                      maxHeight: double.infinity,
                    ),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: AnimatedSizeAndFade(
                                child: widget.isExpanded
                                    ? fullDiscription()
                                    : shortDiscription(),
                              ),
                            ),
                            if (!widget.isExpanded)
                              WidgetSpan(
                                child: GestureDetector(
                                  child: Text(
                                    '\tRead More',
                                    style: CustomResponsiveTextStyles.paragraph5
                                        .copyWith(
                                      color: AppColors.primaryBase,
                                    ),
                                  ),
                                  onTap: () => setState(() {
                                    widget.isExpanded = true;
                                  }),
                                ),
                              ),
                            if (widget.isExpanded)
                              WidgetSpan(
                                child: GestureDetector(
                                  child: Text(
                                    '\tRead Less',
                                    style: CustomResponsiveTextStyles.paragraph5
                                        .copyWith(
                                      color: AppColors.primaryBase,
                                    ),
                                  ),
                                  onTap: () => setState(() {
                                    widget.isExpanded = false;
                                  }),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomTextButtonActive(
                        text: 'Add to Cart', onClick: () {}),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Text shortDiscription() {
    return Text(
      'Short Discription',
      style: CustomResponsiveTextStyles.paragraph5.copyWith(
        color: AppColors.textSecondaryBase,
      ),
    );
  }

  Text fullDiscription() {
    return Text(
      widget.productDiscription,
      style: CustomResponsiveTextStyles.paragraph5.copyWith(
        color: AppColors.textSecondaryBase,
      ),
    );
  }
}
