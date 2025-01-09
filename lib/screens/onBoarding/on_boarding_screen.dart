import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:wasly_template/wasly_template.dart';

class OnboardingScreen extends StatelessWidget {
  final VoidCallback onFinish;
  const OnboardingScreen({Key? key, required this.onFinish}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 16.0, color: Colors.black54);
    const titleStyle = TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    const pageDecoration = PageDecoration(
      titleTextStyle: titleStyle,
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.symmetric(horizontal: 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
      imageAlignment: Alignment.topCenter,
      bodyFlex: 2,
      imageFlex: 4,
    );
    return OnboardingPage(
      onFinish: onFinish,
      pages: [
        PageModel(
            title: 'Browse Our App & Order Directly',
            bodyText: 'The best delivery app you  have ever used!',
            imagePath:
                AppConstants.getAssetPath('customer/onBoarding/Heading.png'),
            titleHighlightColor: AppColors.primaryBase,
            titleOriginalColor: AppColors.textPrimaryBase,
            titleStyle: CustomTextStyles.headingH3,
            bodyStyle: CustomTextStyles.paragraph3.copyWith(
              color: AppColors.textSecondaryBase,
            ),
            pageDecoration: pageDecoration),
        PageModel(
            title: 'Get Your Products from Any Store',
            bodyText:
                'Select your location to see the wide range of your store.',
            imagePath:
                AppConstants.getAssetPath('customer/onBoarding/Heading-1.png'),
            titleHighlightColor: AppColors.primaryBase,
            titleOriginalColor: AppColors.textPrimaryBase,
            titleStyle: CustomTextStyles.headingH3,
            bodyStyle: CustomTextStyles.paragraph3.copyWith(
              color: AppColors.textSecondaryBase,
            ),
            pageDecoration: pageDecoration),
        PageModel(
          title: 'The Fastest Product Delivery Service',
          bodyText:
              'Experience lightning-fast deliveries and get your favorite Products delivered in no time.',
          imagePath:
              AppConstants.getAssetPath('customer/onBoarding/Heading-2.png'),
          titleHighlightColor: AppColors.primaryBase,
          titleOriginalColor: AppColors.textPrimaryBase,
          titleStyle: CustomTextStyles.headingH3,
          bodyStyle: CustomTextStyles.paragraph3.copyWith(
            color: AppColors.textSecondaryBase,
          ),
          pageDecoration: pageDecoration,
        ),
      ],
    );
  }
}
