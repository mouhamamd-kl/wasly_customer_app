import 'package:flutter/material.dart';
import 'package:wasly_template/wasly_template.dart';

final List<Map<String, dynamic>> categories = [
  {
    'icon': AppConstants.getMockUpPath("category.png"),
    'label': 'All',
    'color': Colors.white,
  },
  {
    'icon': AppConstants.getMockUpPath("category.png"),
    'label': 'Toys & Games',
    'color': Colors.pink,
  },
  {
    'icon': AppConstants.getMockUpPath("category.png"),
    'label': 'Electronics',
    'color': Colors.orange,
  },
  {
    'icon': AppConstants.getMockUpPath("category.png"),
    'label': 'Cake',
    'color': Colors.pink,
  },
  {
    'icon': AppConstants.getMockUpPath("category.png"),
    'label': 'Pizza',
    'color': Colors.red,
  },
];
final List<Map<String, dynamic>> sort = [
  {
    'icon': AppConstants.getSortPath("money_1.svg"),
    'label': 'High Price',
    'color': AppColors.textPrimaryBase,
  },
  {
    'icon': AppConstants.getSortPath("money_2.svg"),
    'label': 'Low Price',
    'color': AppColors.textPrimaryBase,
  },
];
