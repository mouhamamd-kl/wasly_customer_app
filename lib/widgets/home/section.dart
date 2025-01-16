import 'package:flutter/material.dart';
import 'package:wasly_template/wasly_template.dart';

class Section extends StatelessWidget {
  final String sectionTitle;
  final String actionText;
  final VoidCallback onActionTap;
  final Widget child;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  const Section(
      {Key? key,
      required this.sectionTitle,
      required this.actionText,
      required this.onActionTap,
      required this.child,
      this.spacing = 0,
      this.mainAxisAlignment = MainAxisAlignment.spaceEvenly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      spacing: spacing,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 0),
              child: Text(
                sectionTitle,
                style: CustomResponsiveTextStyles.buttonText2
                    .copyWith(color: AppColors.textPrimaryBase),
              ),
            ),
            GestureDetector(
              onTap: onActionTap,
              child: Row(
                children: <Widget>[
                  Text(
                    actionText,
                    style: CustomResponsiveTextStyles.buttonText2.copyWith(
                      color: AppColors.primaryBase,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        child,
      ],
    );
  }
}
