import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wasly_template/wasly_template.dart';

class DateFieldWidget extends StatelessWidget {
  final DateTime selectedDate;
  final Function(BuildContext) onSelectDate;

  const DateFieldWidget({
    Key? key,
    required this.selectedDate,
    required this.onSelectDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelectDate(context),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.strokColor,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 20,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 12),
            Text(
              DateFormat('d/MM/yyyy').format(selectedDate),
              style: CustomResponsiveTextStyles.fieldText1,
            ),
          ],
        ),
      ),
    );
  }
}
