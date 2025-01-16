import 'package:flutter/material.dart';
import 'package:wasly_template/wasly_template.dart';

class PriceRow extends StatelessWidget {
  const PriceRow({
    super.key,
    required this.label,
    required this.value,
    required this.isTotal,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: CustomResponsiveTextStyles.paragraph3.copyWith(
            color: AppColors.textSecondaryBase,
          ),
        ),
        Text(
          value,
          style: CustomResponsiveTextStyles.headingH10.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBase,
          ),
        ),
      ],
    );
  }
}
