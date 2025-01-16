import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasly_template/wasly_template.dart';

class StoreDetails extends StatelessWidget {
  const StoreDetails({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 30,
          children: [
            StoreProfileContainer(
              wallpaperImagePath: 'assets/images/wallpaper.png',
              profileImagePath: 'assets/images/image.png',
              storeName: 'Pizza Hut',
              location: 'Damascus - Barzeh',
              rate: 4.4,
              numberOfRating: 100,
              inCenter: false,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                spacing: 30,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppConstants.getIconPath("bike.svg"),
                      ),
                      Text(
                        "Free Delivery",
                        style: CustomResponsiveTextStyles.paragraph4.copyWith(
                          color: AppColors.textPrimaryBase,
                        ),
                      ),
                      Spacer(flex: 1),
                      SvgPicture.asset(
                        AppConstants.getIconPath("timer.svg"),
                      ),
                      Text(
                        "15 - 20 mins",
                        style: CustomResponsiveTextStyles.paragraph4.copyWith(
                          color: AppColors.textPrimaryBase,
                        ),
                      ),
                      Spacer(flex: 4),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recommended Items",
                        style: CustomResponsiveTextStyles.headingH9.copyWith(
                          color: AppColors.textPrimaryBase,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "View All",
                          style:
                              CustomResponsiveTextStyles.buttonText2.copyWith(
                            color: AppColors.primaryBase,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: SizedBox(
                      width: screenWidth,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SmallCardContainer(
                              name: 'ASUS ROG Strix Pro 7.1',
                              imagePath: AppConstants.getMockUpPath(
                                "small_product_image.png",
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  CustomSearchField(
                    controller: TextEditingController(),
                    hintText: 'Search Items',
                    prefix: SvgPicture.asset(
                      AppConstants.getIconPath('search.svg'),
                      fit: BoxFit.scaleDown,
                    ),
                    fillColor: Color(0XFFF8FAFC),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.72,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 232 / 150 * screenWidth / 2.4,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 30,
                      ),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return SmallCardContainer(
                          name: 'ASUS ROG Strix Pro 7.1',
                          imagePath: AppConstants.getMockUpPath(
                            "small_product_image.png",
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
