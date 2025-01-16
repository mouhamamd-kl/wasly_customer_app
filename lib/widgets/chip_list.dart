import 'package:flutter/material.dart';
import 'package:wasly/core/helper.dart';
import 'package:wasly/models/category.dart';
import 'package:wasly/widgets/chip_item.dart';
import 'package:wasly_template/wasly_template.dart';

class ChipList extends StatefulWidget {
  final Function(String) onCategorySelected;
  final List<Category> list;

  const ChipList({
    Key? key,
    required this.list,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  State<ChipList> createState() => _ChipListState();
}

class _ChipListState extends State<ChipList> {
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    // Initialize with first item's label
    _selectedCategory = widget.list.first.name;
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
        final isSelected = category.name == _selectedCategory;
        return ChipItem(
          icon: category.photo,
          label: category.name,
          color: Helper.parseStringToColor(category.color),
          isSelected: isSelected,
          onTap: () {
            setState(() {
              _selectedCategory = category.name;
            });
            widget.onCategorySelected(category.name);
          },
        );
      },
    );
  }
}
