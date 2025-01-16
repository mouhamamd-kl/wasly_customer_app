import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_here/hero_here.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wasly/bindings/binding.dart';
import 'package:wasly/controllers/auth/auth_controller.dart';
import 'package:wasly/controllers/routing/rout_observer.dart';
import 'package:wasly/controllers/services/storage/secure_storage_service.dart';
import 'package:wasly/screens/auth/login_screen.dart';
import 'package:wasly/screens/auth/starting_screen.dart';
import 'package:wasly/screens/delivery/delivery_history_screen.dart';
import 'package:wasly/screens/favourite/favourite_screen.dart';
import 'package:wasly/screens/home_screen.dart';
import 'package:wasly/screens/location/add_new_location_screen.dart';
import 'package:wasly/screens/onBoarding/on_boarding_screen.dart';
import 'package:wasly/screens/order/order_screen.dart';
import 'package:wasly/screens/profile/edit_profile_screen.dart';
import 'package:wasly/screens/splash_screen%20copy.dart';
import 'package:wasly/screens/store/home_store_screen.dart';
import 'package:wasly_template/wasly_template.dart';

void main() {
  runApp(const MyApp());
}

const kHeroTag = 'hero';

Future<void> _requestLocationPermission() async {
  var status = await Permission.location.request();

  if (status.isGranted) {
    print("Location permission granted.");
  } else if (status.isDenied) {
    print("Location permission denied.");
  } else if (status.isPermanentlyDenied) {
    print("Location permission permanently denied.");
    openAppSettings(); // Open app settings if permanently denied
  }
}

Future<void> _requestPhotoPermission() async {
  var status = await Permission.photos.request();

  if (status.isGranted) {
    print("Location permission granted.");
  } else if (status.isDenied) {
    print("Location permission denied.");
  } else if (status.isPermanentlyDenied) {
    print("Location permission permanently denied.");
    openAppSettings(); // Open app settings if permanently denied
  }
}

Future<void> _requestNotificationPermission() async {
  var status = await Permission.notification.request();

  if (status.isGranted) {
    print("notification permission granted.");
  } else if (status.isDenied) {
    print("notification permission denied.");
  } else if (status.isPermanentlyDenied) {
    print("notification permission permanently denied.");
    openAppSettings(); // Open app settings if permanently denied
  }
}

Future<void> initRequests() async {
  await _requestNotificationPermission();
  await _requestPhotoPermission();
  await _requestLocationPermission();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return DevicePreview(
      builder: (context) => GetMaterialApp(
        onInit: _requestLocationPermission,
        initialBinding: CustomerBinding(),
        home: authController.isLoggedIn.value
            ? HomeScreen()
            : SplashScreen(
                nextScreen: OnboardingScreen(
                  onFinish: () async {
                    // Observe the login status and navigate accordingly

                    await Get.offAll(() => LoginScreen());
                  },
                ),
                backgroundColor: AppColors.primaryBase,
              ),

        // OrderScreen(),
        routingCallback: (routing) {
          if (routing?.current != null) {
            RouteObserver2.routeHistory.add(routing!.current);
          }
        },
        // HomePage(),
        builder: (BuildContext ctx, Widget? widget) {
          // ...

          return DevicePreview.appBuilder(ctx, widget);
          // ...
        },

        // ...
      ),
    );
    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   theme: CustomTheme.theme,
    //   home: LoginScreen(),
    //  SplashScreen(
    //   nextScreen: OnboardingScreen(
    //     onFinish: () async {
    //       await Get.to(HomePage());
    //     },
    //   ),
    //   backgroundColor: AppColors.primaryBase,
    // ),
    //   getPages: [
    //     // GetPage(name: '/', page: () => OnboardingScreen(onFinish: ,)),
    //     // GetPage(name: '/home', page: () => HomePage()),
    //   ],
    // );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _onBackToIntro(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (_) => OnboardingScreen(
                onFinish: () async {
                  await Get.to(() => StartingScreen());
                },
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ExpandingProductCard(
            name: "Asus Mouse",
            imageUrl: "https://i.imgur.com/0D1AgqE.png",
            price: 299.0,
            itemCount: 200,
            numberOfRating: 200,
            rate: 4.0,
            status: "Pendeing"),
      ),
    );
  }
}
