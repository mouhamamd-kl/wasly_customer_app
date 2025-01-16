import 'package:flutter/material.dart';
import 'package:wasly/core/helper.dart';
import 'package:wasly/models/category.dart';
import 'package:wasly/widgets/chip_item.dart';
import 'package:wasly_template/wasly_template.dart';

class SortList extends StatefulWidget {
  final Function(String) onCategorySelected;
  final List<Map<String, dynamic>> list;

  const SortList({
    Key? key,
    required this.list,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  State<SortList> createState() => _SortListState();
}

class _SortListState extends State<SortList> {
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    // Initialize with first item's label
    _selectedCategory = widget.list.first['label'];
    // Use Future.microtask to call onCategorySelected after the build is complete
    Future.microtask(() {
      widget.onCategorySelected(_selectedCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
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
