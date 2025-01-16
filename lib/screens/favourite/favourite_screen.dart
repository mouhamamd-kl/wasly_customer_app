import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasly/controllers/nav_controller.dart';
import 'package:wasly/controllers/services/category/category_service.dart';
import 'package:wasly/core/constant_widgets/navigation_bar.dart';
import 'package:wasly/widgets/favorutite_product_card.dart';
import 'package:wasly/widgets/search/search_widget.dart';
import 'package:wasly_template/wasly_template.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  final controller = Get.find<NavController>();
  final List<Map<String, String>> products = [
    {"name": "Asus mouse", "image": "https://i.imgur.com/0D1AgqE.png"},
    {"name": "Asus mouse", "image": "https://i.imgur.com/0D1AgqE.png"},
    {"name": "Asus mouse", "image": "https://i.imgur.com/0D1AgqE.png"},
    {"name": "Asus mouse", "image": "https://i.imgur.com/0D1AgqE.png"},
    {"name": "Asus mouse", "image": "https://i.imgur.com/0D1AgqE.png"},
    {"name": "Asus mouse", "image": "https://i.imgur.com/0D1AgqE.png"},
    {"name": "Asus mouse", "image": "https://i.imgur.com/0D1AgqE.png"},
    {"name": "Asus mouse", "image": "https://i.imgur.com/0D1AgqE.png"},
    {"name": "Asus mouse", "image": "https://i.imgur.com/0D1AgqE.png"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("favourite Screen"),
        centerTitle: true,
      ),
      bottomNavigationBar: Obx(
        () => CustomBottomNavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onTap: controller.updateIndex,
          items: bottomNavItems,
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SearchFilterWidget(
                  onSearchTap: () {},
                  categoriesFuture: CategoryService().getCategories(),
                  onFilterApplied:
                      (searchText, selectedCategory, sortOption, priceRange) {
                    print("Search Text: $searchText");
                    print("Selected Category: $selectedCategory");
                    print("Sort Option: $sortOption");
                    print(
                        "Price Range: ${priceRange.start} - ${priceRange.end}");
                  },
                ),
                SizedBox(
                    height:
                        20), // Add some spacing between the search field and the grid
                Flexible(
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 16, // Horizontal spacing between items
                      runSpacing: 16, // Vertical spacing between items
                      children: products.map((product) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width / 2 -
                              24, // Half the screen width minus padding
                          child: FavorutiteProductCard(
                            name: product["name"]!,
                            imagePath: product["image"]!,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
