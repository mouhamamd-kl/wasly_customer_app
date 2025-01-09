import 'package:get/get.dart';
import 'package:wasly/controllers/nav_controller.dart';

class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavController());
  }
}
