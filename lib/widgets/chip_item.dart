import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wasly_template/wasly_template.dart';

class ChipItem extends StatelessWidget {
  final String icon;
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const ChipItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        child: AnimatedContainer(
          padding: EdgeInsets.all(8.0),
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryBase
                : Color.fromRGBO(248, 250, 252, 1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            spacing: 5,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 34,
                width: 34,
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(100),
                ),
                child:
                    icon.isURL ? Image.network(icon) : SvgPicture.asset(icon),
              ),
              Text(
                label,
                style: CustomResponsiveTextStyles.buttonText2.copyWith(
                  color: isSelected ? AppColors.backgroundAccent : color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
