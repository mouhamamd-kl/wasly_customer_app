//v0
// class ProductCard extends StatefulWidget {
//   final String imageUrl;
//   final String name;
//   final String price;
//   final String description;

//   const ProductCard({
//     Key? key,
//     required this.imageUrl,
//     required this.name,
//     required this.price,
//     required this.description,
//   }) : super(key: key);

//   @override
//   _ProductCardState createState() => _ProductCardState();
// }

// class _ProductCardState extends State<ProductCard>
//     with SingleTickerProviderStateMixin {
//   bool _isExpanded = false;
//   late AnimationController _controller;
//   late Animation<double> _rotationAnimation;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );

//     _rotationAnimation = Tween<double>(
//       begin: 0,
//       end: 0.087, // 5 degrees in radians
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));

//     _scaleAnimation = Tween<double>(
//       begin: 1,
//       end: 1.1,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _toggleExpanded() {
//     setState(() {
//       _isExpanded = !_isExpanded;
//       if (_isExpanded) {
//         _controller.forward();
//       } else {
//         _controller.reverse();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _toggleExpanded,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//         width: _isExpanded ? 350 : 250,
//         height: _isExpanded ? 550 : 350,
//         decoration: BoxDecoration(
//           color: const Color(0xFF2D2654), // Deep purple color from the image
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 10,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               AnimatedBuilder(
//                 animation: _controller,
//                 builder: (context, child) {
//                   return Transform.scale(
//                     scale: _scaleAnimation.value,
//                     child: Transform.rotate(
//                       angle: _rotationAnimation.value,
//                       child: _buildProductImage(),
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: 20),
//               _buildProductInfo(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProductImage() {
//     return Container(
//       height: _isExpanded ? 200 : 150,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Image.network(
//         "https://dlcdnwebimgs.asus.com/files/media/56004EC5-EB0C-4DEA-84C0-4FE7CF03E79E/V1/img/delta/spec-delta-origin.png",
//         fit: BoxFit.contain,
//         errorBuilder: (context, error, stackTrace) {
//           return const Icon(
//             Icons.error_outline,
//             color: Colors.white,
//             size: 50,
//           );
//         },
//         loadingBuilder: (context, child, loadingProgress) {
//           if (loadingProgress == null) return child;
//           return const Center(
//             child: CircularProgressIndicator(
//               color: Colors.white,
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildProductInfo() {
//     return AnimatedOpacity(
//       duration: const Duration(milliseconds: 300),
//       opacity: 1.0,
//       child: Column(
//         children: [
//           Text(
//             widget.name,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             widget.price,
//             style: TextStyle(
//               color: Colors.purple[100],
//               fontSize: 20,
//             ),
//           ),
//           if (_isExpanded) ...[
//             const SizedBox(height: 16),
//             Text(
//               widget.description,
//               style: const TextStyle(
//                 color: Colors.white70,
//                 fontSize: 14,
//                 height: 1.5,
//               ),
//               textAlign: TextAlign.center,
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 20),
//             _buildBuyNowButton(),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildBuyNowButton() {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.symmetric(
//           horizontal: 30,
//           vertical: 12,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(25),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.white.withOpacity(0.2),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: const Text(
//           'Buy Now',
//           style: TextStyle(
//             color: Color(0xFF2D2654),
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DetailedproductCart extends StatelessWidget {
//   const DetailedproductCart({
//     super.key,
//     required this.name,
//     required this.rating,
//     required this.reviews,
//     required this.imageUrl,
//     required this.price,
//     required this.itemCount,
//   });

//   final String name;
//   final double rating;
//   final int reviews;
//   final String imageUrl;
//   final double price;
//   final int itemCount;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 300,
//       margin: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Status indicator
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF8B5CF6).withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: const Text(
//                         'pending',
//                         style: TextStyle(
//                           color: Color(0xFF8B5CF6),
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     // Rating container
//                     Hero(
//                       tag: 'rating_$name',
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Row(
//                           children: [
//                             Text(
//                               rating.toString(),
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             const SizedBox(width: 4),
//                             const Icon(
//                               Icons.star,
//                               color: Colors.white,
//                               size: 12,
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               '(${reviews.toString()}+)',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 // Product image
//                 Center(
//                   child: Hero(
//                     tag: 'image_$name',
//                     child: Container(
//                       height: 200,
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                             spreadRadius: 2,
//                           ),
//                         ],
//                       ),
//                       child: Image.network(
//                         imageUrl,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 // Product name
//                 Hero(
//                   tag: 'name_$name',
//                   child: Text(
//                     name,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 // Price and item count
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Hero(
//                       tag: 'price_$name',
//                       child: Text(
//                         '\$$price',
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       'item count: $itemCount',
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 // Re Add To Cart button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF8B5CF6),
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       'Re Add To Cart',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProductCard extends StatelessWidget {
//   final String imageUrl;
//   final String name;
//   final double price;
//   final double rating;
//   final int reviews;

//   const ProductCard({
//     Key? key,
//     required this.imageUrl,
//     required this.name,
//     required this.price,
//     required this.rating,
//     required this.reviews,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 300,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Top row with rating and price
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Rating container
//               Hero(
//                 tag: 'rating_$name',
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Row(
//                     children: [
//                       Text(
//                         rating.toString(),
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       const Icon(
//                         Icons.star,
//                         color: Colors.white,
//                         size: 12,
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         '(${reviews.toString()}+)',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               // Price
//               Hero(
//                 tag: 'price_$name',
//                 child: Text(
//                   '\$$price',
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           // Product image
//           Center(
//             child: Hero(
//               tag: 'image_$name',
//               child: Container(
//                 height: 200,
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 20,
//                       offset: const Offset(0, 10),
//                       spreadRadius: 2,
//                     ),
//                   ],
//                 ),
//                 child: Image.network(
//                   imageUrl,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           // Product name
//           Hero(
//             tag: 'name_$name',
//             child: Text(
//               name,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black87,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
