import 'package:flutter/material.dart';
import 'package:wasly/widgets/chip_item.dart';
import 'package:wasly_template/wasly_template.dart';

class ChipList extends StatefulWidget {
  final Function(String) onCategorySelected;
  final List<Map<String, dynamic>> list;
  const ChipList({
    Key? key,
    required this.list,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  State<ChipList> createState() => _ChipListState();
}

class _ChipListState extends State<ChipList> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Important to make it take only the required height
      scrollDirection: Axis.horizontal,
      itemCount: widget.list.length,

      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        final category = widget.list[index];
        final isSelected = category['label'] == _selectedCategory;
        return ChipItem(
          icon: category['icon'],
          label: category['label'],
          color: category['color'],
          isSelected: isSelected,
          onTap: () {
            setState(() {
              _selectedCategory = category['label'];
            });
            widget.onCategorySelected(category['label']);
          },
        );
      },
    );
  }
}
