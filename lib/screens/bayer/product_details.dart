// // ignore_for_file: must_be_immutable

// import 'package:animated_size_and_fade/animated_size_and_fade.dart';
// import 'package:flutter/material.dart';
// import 'package:wasly_template/wasly_template.dart';

// class ProductDetails extends StatefulWidget {
//   bool isExpanded = false;
//   String imagePath;
//   String productName;
//   String storeName;
//   double productRate;
//   int ratingNumber;
//   double productPrice;
//   String productDiscription;

//   ProductDetails({
//     super.key,
//     required this.imagePath,
//     required this.productName,
//     required this.storeName,
//     required this.productRate,
//     required this.ratingNumber,
//     required this.productPrice,
//     required this.productDiscription,
//   });

//   @override
//   State<ProductDetails> createState() => _ProductDetailsState();
// }

// class _ProductDetailsState extends State<ProductDetails> {
//   @override
//   Widget build(BuildContext context) {
//     double screenHieght = MediaQuery.sizeOf(context).height;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           spacing: 20,
//           children: [
//             ProfileWallpaper(wallpaperImagePath: widget.imagePath),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 spacing: 20,
//                 children: [
//                   Row(
//                     children: [
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         spacing: 8,
//                         children: [
//                           Text(
//                             widget.productName,
//                             style:
//                                 CustomResponsiveTextStyles.headingH5.copyWith(
//                               color: AppColors.textPrimaryBase,
//                             ),
//                           ),
//                           Text(
//                             'From ${widget.storeName}',
//                             style:
//                                 CustomResponsiveTextStyles.paragraph1.copyWith(
//                               color: AppColors.textSecondaryBase,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Spacer(),
//                       RatingcontainerLight(
//                         rate: widget.productRate,
//                         numberOfRating: widget.ratingNumber,
//                         backgroundOpacity: 0,
//                       ),
//                       GestureDetector(
//                         child: Text(
//                           'see all reviews',
//                           style:
//                               CustomResponsiveTextStyles.buttonText5.copyWith(
//                             color: AppColors.primaryBase,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     spacing: 5,
//                     children: [
//                       Text(
//                         "\$${widget.productPrice}",
//                         style: CustomResponsiveTextStyles.headingH3.copyWith(
//                           color: AppColors.textPrimaryBase,
//                         ),
//                       ),
//                       Spacer(),
//                       CounterWidget(),
//                     ],
//                   ),
//                   ConstrainedBox(
//                     constraints: BoxConstraints(
//                       minHeight: screenHieght * 0.15,
//                       maxHeight: double.infinity,
//                     ),
//                     child: Container(
//                       width: double.infinity,
//                       alignment: Alignment.topLeft,
//                       child: RichText(
//                         text: TextSpan(
//                           children: [
//                             WidgetSpan(
//                               child: AnimatedSizeAndFade(
//                                 child: widget.isExpanded
//                                     ? fullDiscription()
//                                     : shortDiscription(),
//                               ),
//                             ),
//                             if (!widget.isExpanded)
//                               WidgetSpan(
//                                 child: GestureDetector(
//                                   child: Text(
//                                     '\tRead More',
//                                     style: CustomResponsiveTextStyles.paragraph5
//                                         .copyWith(
//                                       color: AppColors.primaryBase,
//                                     ),
//                                   ),
//                                   onTap: () => setState(() {
//                                     widget.isExpanded = true;
//                                   }),
//                                 ),
//                               ),
//                             if (widget.isExpanded)
//                               WidgetSpan(
//                                 child: GestureDetector(
//                                   child: Text(
//                                     '\tRead Less',
//                                     style: CustomResponsiveTextStyles.paragraph5
//                                         .copyWith(
//                                       color: AppColors.primaryBase,
//                                     ),
//                                   ),
//                                   onTap: () => setState(() {
//                                     widget.isExpanded = false;
//                                   }),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     child: CustomTextButtonActive(
//                         text: 'Add to Cart', onClick: () {}),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Text shortDiscription() {
//     return Text(
//       'Short Discription',
//       style: CustomResponsiveTextStyles.paragraph5.copyWith(
//         color: AppColors.textSecondaryBase,
//       ),
//     );
//   }

//   Text fullDiscription() {
//     return Text(
//       widget.productDiscription,
//       style: CustomResponsiveTextStyles.paragraph5.copyWith(
//         color: AppColors.textSecondaryBase,
//       ),
//     );
//   }
// }
import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:wasly/controllers/services/favrourite/favorite_service.dart';
import 'package:wasly/controllers/services/product/product_service.dart';
import 'package:wasly/models/product.dart';
import 'package:wasly/screens/favourite/favourite_screen.dart';
import 'package:wasly_template/wasly_template.dart';

class ProductDetails extends StatefulWidget {
  final int productId;

  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late ProductService _productService;
  Product? product;
  bool isExpanded = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _productService = ProductService();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    try {
      final fetchedProduct =
          await _productService.getProductById(widget.productId);
      setState(() {
        product = fetchedProduct;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching product: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (product == null) {
      return const Scaffold(
        body: Center(child: Text("Product not found")),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            ProfileWallpaper(
              wallpaperImagePath: product!.photo,
              save: () {
                FavouriteService service = FavouriteService();
                service.addToFavourites(product!.id);
              },
            ),
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
                            product!.name,
                            style:
                                CustomResponsiveTextStyles.headingH5.copyWith(
                              color: AppColors.textPrimaryBase,
                            ),
                          ),
                          Text(
                            'From ${product!.store?.name ?? "Unknown"}',
                            style:
                                CustomResponsiveTextStyles.paragraph1.copyWith(
                              color: AppColors.textSecondaryBase,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      RatingcontainerLight(
                        rate: product!.averageRating ?? 0.0,
                        numberOfRating: 100, // Placeholder, adjust as needed
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
                        "\$${product!.price}",
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
                      minHeight: screenHeight * 0.15,
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
                                child: isExpanded
                                    ? fullDescription()
                                    : shortDescription(),
                              ),
                            ),
                            if (!isExpanded)
                              WidgetSpan(
                                child: GestureDetector(
                                  child: Text(
                                    '\tRead More',
                                    style: CustomResponsiveTextStyles.paragraph5
                                        .copyWith(
                                      color: AppColors.primaryBase,
                                    ),
                                  ),
                                  onTap: () =>
                                      setState(() => isExpanded = true),
                                ),
                              ),
                            if (isExpanded)
                              WidgetSpan(
                                child: GestureDetector(
                                  child: Text(
                                    '\tRead Less',
                                    style: CustomResponsiveTextStyles.paragraph5
                                        .copyWith(
                                      color: AppColors.primaryBase,
                                    ),
                                  ),
                                  onTap: () =>
                                      setState(() => isExpanded = false),
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

  Text shortDescription() {
    return Text(
      product!.description,
      maxLines: 3,
      style: CustomResponsiveTextStyles.paragraph5.copyWith(
        color: AppColors.textSecondaryBase,
      ),
    );
  }

  Text fullDescription() {
    return Text(
      product!.description,
      style: CustomResponsiveTextStyles.paragraph5.copyWith(
        color: AppColors.textSecondaryBase,
      ),
    );
  }
}
