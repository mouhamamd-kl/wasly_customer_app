import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasly_template/core/widgets/text/text_paragraph_4.dart';
import 'package:wasly_template/wasly_template.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.icon,
    required this.label,
    required this.description,
    required this.isSelected,
    required this.hasAddButton,
    required this.onTap,
  });

  final String icon;
  final String label;
  final String description;
  final bool isSelected;
  final bool hasAddButton;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primaryBase : AppColors.primaryLight,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextHeading10(text: label),
                  TextParagraph4(text: description),
                ],
              ),
            ),
            if (hasAddButton)
              SizedBox(
                height: 26,
                width: 26,
                child: ElevatedButton(
                  onPressed: () {
                    // Add Card Action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBase,
                    padding: EdgeInsets.all(0.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: Icon(Icons.add_rounded, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
