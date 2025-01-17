import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:wasly/widgets/gender_widget.dart';
import 'package:wasly_template/core/widgets/Border/custom_outline_input_border.dart';
import 'package:wasly_template/wasly_template.dart';

class GenderSelectWidget extends StatelessWidget {
  final String? selectedGender;
  final List<Map<String, String>> genders;
  final ValueChanged<String?>? onChanged;

  const GenderSelectWidget({
    Key? key,
    required this.selectedGender,
    required this.genders,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      value: selectedGender,
      isExpanded: true,
      style: CustomResponsiveTextStyles.fieldText4.copyWith(
        color: AppColors.textSecondaryBase,
      ),
      decoration: InputDecoration(
        enabledBorder: CustomOutlineInputBorder.defaultBorder(),
        focusedBorder: CustomOutlineInputBorder.focusedBorder(),
      ),
      items: genders
          .map(
            (item) => DropdownMenuItem<String>(
              value: item['name'],
              child: GenderWidget(
                gender: item['name']!,
                icon: item['icon']!,
              ),
            ),
          )
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select a gender.';
        }
        return null;
      },
      onChanged: onChanged,
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
