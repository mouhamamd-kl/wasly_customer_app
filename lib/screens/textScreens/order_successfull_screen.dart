import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wasly/screens/home_screen.dart';
import 'package:wasly_template/core/widgets/text/text_paragraph_5.dart';
import 'package:wasly_template/wasly_template.dart';

class OrderSuccessfullScreen extends StatefulWidget {
  const OrderSuccessfullScreen({super.key});

  @override
  State<OrderSuccessfullScreen> createState() => _OrderSuccessfullScreenState();
}

class _OrderSuccessfullScreenState extends State<OrderSuccessfullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppConstants.getTextScreensIcons("order_successfull.svg"),
                ),
                TextHeading4(
                  text: "Order Successful",
                ),
                TextParagraph5(
                  text:
                      "Your order is successfully placed. Chill and wait your order will deliver soon!",
                ),
              ],
            ),
            Spacer(),
            CustomTextButtonActive(
              text: "Back to Home",
              onClick: () {
                Get.offAll(HomeScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
