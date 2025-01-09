import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  final Widget nextScreen;
  final Color backgroundColor;

  const SplashScreen({
    Key? key,
    required this.nextScreen,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  Duration? _animationDuration;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    // Listen for when the animation is loaded to get its duration
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.stop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      useImmersiveMode: true,
      duration: _animationDuration ?? const Duration(milliseconds: 2600),
      nextScreen: widget.nextScreen,
      backgroundColor: widget.backgroundColor,
      splashScreenBody: Center(
        child: Lottie.asset(
          frameRate: FrameRate(60),
          "assets/animation/lottie/test.json",
          controller: _controller,
          repeat: false,
          onLoaded: (composition) {
            _controller.duration = composition.duration;
            setState(() {
              _animationDuration = composition.duration;
            });
            _controller.forward();
          },
        ),
      ),
    );
  }
}
