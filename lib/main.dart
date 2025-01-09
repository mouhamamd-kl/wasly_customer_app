import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wasly/bindings/binding.dart';
import 'package:wasly/screens/auth/starting_screen.dart';
import 'package:wasly/screens/home_screen.dart';
import 'package:wasly/screens/onBoarding/on_boarding_screen.dart';
import 'package:wasly_template/core/widgets/general/price_range_slider.dart';
import 'package:wasly_template/core/widgets/text/text_button_1.dart';
import 'package:wasly_template/wasly_template.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      builder: (context) => GetMaterialApp(
        initialBinding: CustomerBinding(),
        home:
            // SplashScreen(
            //   nextScreen: OnboardingScreen(
            //     onFinish: () async {
            //       await Get.to(LoginScreen());
            //     },
            //   ),
            //   backgroundColor: AppColors.primaryBase,
            // ),
            HomeScreen(),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("This is the screen after Introduction"),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _onBackToIntro(context),
              child: const Text('Back to Introduction'),
            ),
          ],
        ),
      ),
    );
  }
}

class RangeSliderDemo extends StatefulWidget {
  const RangeSliderDemo({super.key});

  @override
  State<RangeSliderDemo> createState() => _RangeSliderDemoState();
}

class _RangeSliderDemoState extends State<RangeSliderDemo> {
  RangeValues _currentRangeValues = const RangeValues(20, 80);
  final List<double> barHeights = [
    30,
    45,
    60,
    75,
    90,
    100,
    85,
    70,
    55,
    40,
    50,
    65,
    80,
    95,
    85,
    70,
    55,
    40,
    35,
    30
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Center(
      child: Container(
        child: PriceRangeSlider(
          min: 0,
          max: 1000,
          initialValues: const RangeValues(200, 800),
          onChanged: (values) {
            // Handle the range changes here
            print(
                'Min: \$${values.start.toStringAsFixed(0)}, Max: \$${values.end.toStringAsFixed(0)}');
          },
        ),
      ),
    )));
  }
}
