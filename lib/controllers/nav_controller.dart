import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wasly/screens/cart/cart_screen.dart';
import 'package:wasly/screens/favourite/favourite_screen.dart';
import 'package:wasly/screens/order/order_screen.dart';
import '../screens/home_screen.dart';

class NavController extends GetxController {
  var selectedIndex = 0.obs;

  final pages = [
    HomeScreen(),
    FavouriteScreen(),
    CartScreen(),
    OrderScreen(),
  ];

  void updateIndex(int index) {
    if (selectedIndex.value != index) {
      selectedIndex.value = index;
      StatefulWidget screen = pages[index];
      Get.offAll(() => screen,
          transition:
              Transition.native, // choose your page transition accordingly
          duration: const Duration(milliseconds: 0),
          curve: Curves.ease);
    }
  }
}
