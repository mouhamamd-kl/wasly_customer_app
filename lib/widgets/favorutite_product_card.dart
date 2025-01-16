import 'package:flutter/material.dart';
import 'package:wasly_template/core/widgets/text/text_heading_7.dart';
import 'package:wasly_template/core/widgets/text/text_heading_9.dart';
import 'package:wasly_template/wasly_template.dart';

class FavorutiteProductCard extends StatefulWidget {
  final String name;
  final String imagePath;

  const FavorutiteProductCard({
    Key? key,
    required this.name,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<FavorutiteProductCard> createState() => _FavorutiteProductCardState();
}

class _FavorutiteProductCardState extends State<FavorutiteProductCard> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          boxShadow: AppShadows.normalCombinedShadows,
          color: isFavorite
              ? AppShadows.favoriteProductBackground
              : AppShadows.normalProductBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: toggleFavorite,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: Image(
                      key: ValueKey<bool>(isFavorite),
                      image: AssetImage(
                        isFavorite
                            ? AppConstants.getFavouriteIcons("filled_heart.png")
                            : AppConstants.getFavouriteIcons("like.png"),
                      ),
                      height: 20,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                SizedBox(
                  height: 100, // Set a consistent height for the image
                  child: Image.network(
                    widget.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
                TextHeading7(text: widget.name, textAlign: TextAlign.center),
              ],
            )
          ],
        ),
      ),
    );
  }
}
