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
    'label': 'high_to_low',
    'color': AppColors.textPrimaryBase,
  },
  {
    'icon': AppConstants.getSortPath("money_2.svg"),
    'label': 'low_to_high',
    'color': AppColors.textPrimaryBase,
  },
];
final List<Map<String, dynamic>> locationLabelIcons = [
  {
    "icon": AppConstants.getLabelLocationPath("home.png"),
    "label": "Home",
    "color": AppColors.primaryBase,
  },
  {
    "icon": AppConstants.getLabelLocationPath("work.png"),
    "label": "Office",
    "color": AppColors.primaryBase,
  }
];
