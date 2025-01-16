import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasly/core/test_data/testData.dart';
import 'package:wasly/models/category.dart';
import 'package:wasly/widgets/chip_list.dart';
import 'package:wasly/widgets/sort_list.dart';
import 'package:wasly_template/core/widgets/Border/custom_outline_input_border.dart';
import 'package:wasly_template/core/widgets/general/price_range_slider.dart';
import 'package:wasly_template/core/widgets/text/text_heading_9.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasly_template/wasly_template.dart';

class SearchFilterWidget extends StatefulWidget {
  final Future<List<Category>> categoriesFuture;
  final Function(String searchText, String selectedCategory, String sortOption,
      RangeValues priceRange) onFilterApplied;
  final Function onSearchTap;
  const SearchFilterWidget({
    Key? key,
    required this.categoriesFuture,
    required this.onFilterApplied,
    required this.onSearchTap,
  }) : super(key: key);

  @override
  State<SearchFilterWidget> createState() => _SearchFilterWidgetState();
}

class _SearchFilterWidgetState extends State<SearchFilterWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = '';
  String _selectedSortOption = '';
  RangeValues _priceRange = const RangeValues(200, 800);

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onFiltersChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onFiltersChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onFiltersChanged() {
    widget.onFilterApplied(
      _searchController.text,
      _selectedCategory,
      _selectedSortOption,
      _priceRange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomSearchField(
      fillColor: const Color(0xfff8fafc),
      controller: _searchController,
      hintText: "Search Products and Stores",
      border: CustomOutlineInputBorder.defaultBorder(
        borderRadius: 100,
        borderColor: AppColors.backgroundAccent,
      ),
      onChanged: (p0) {
        setState(() {
          _searchController.text = p0;
          _onFiltersChanged();
        });
      },
      suffix: GestureDetector(
        onTap: _showFilterBottomSheet,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              AppConstants.getIconPath("filter.svg"),
              height: 16,
              width: 16,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
      prefix: GestureDetector(
        onTap: () {
          widget.onSearchTap;
        },
        child: SvgPicture.asset(
          AppConstants.getIconPath("search.svg"),
          height: 16,
          width: 16,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Categories
                const TextHeading9(text: "Categories"),
                SizedBox(
                  height: 50,
                  child: FutureBuilder<List<Category>>(
                    future: widget.categoriesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No categories available'),
                        );
                      }

                      final categories = snapshot.data!;
                      return ChipList(
                        list: categories,
                        onCategorySelected: (selected) {
                          setState(() {
                            _selectedCategory = selected;
                            _onFiltersChanged();
                          });
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Sort by
                const TextHeading9(text: "Sort By"),
                SizedBox(
                  height: 50,
                  child: SortList(
                    list: sort,
                    onCategorySelected: (selected) {
                      setState(() {
                        _selectedSortOption = selected;
                        _onFiltersChanged();
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Price Range
                const TextHeading9(text: "Price Range"),
                PriceRangeSlider(
                  min: 0,
                  max: 1000,
                  initialValues: _priceRange,
                  onChanged: (values) {
                    setState(() {
                      _priceRange = values;
                      _onFiltersChanged();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
