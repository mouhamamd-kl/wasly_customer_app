import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({
    super.key,
    required this.gender,
    required this.icon,
  });

  final String gender;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          width: 20,
          height: 20,
        ),
        const SizedBox(width: 10),
        Text(
          gender,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
