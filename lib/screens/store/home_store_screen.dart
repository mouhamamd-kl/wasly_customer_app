import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wasly/controllers/nav_controller.dart';
import 'package:wasly/core/constant_widgets/navigation_bar.dart';
import 'package:wasly/screens/store/pending_order_card.dart';
import 'package:wasly/screens/store/pending_order_sheet.dart';
import 'package:wasly/screens/store/running_order_sheet.dart';
import 'package:wasly/widgets/custom_drawer.dart';
import 'package:wasly_template/core/widgets/text/text_button_1.dart';
import 'package:wasly_template/core/widgets/text/text_heading_9.dart';
import 'package:wasly_template/wasly_template.dart';

class HomeStoreScreen extends StatelessWidget {
  HomeStoreScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu), // Drawer icon
          onPressed: () {
            // Open the drawer when the icon is pressed
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisSize:
                  MainAxisSize.min, // Ensures the Row takes minimum width
              children: [
                Text(
                  "LOCATION",
                  style: CustomResponsiveTextStyles.fieldText3
                      .copyWith(color: AppColors.primaryBase),
                ),
                const SizedBox(width: 5), // Add spacing between text and arrow
                SvgPicture.asset(
                  AppConstants.getIconPath("arrow_down.svg"),
                  height: 10, // Adjust icon size as needed
                ),
              ],
            ),
            const TextHeading9(text: "46 Larkrow, London"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              size: 44,
            ), // User icon
            onPressed: () {
              // Handle user icon action
            },
          ),
        ],
      ),
      drawer: CustomDrawer(), // Attach the CustomDrawer
      bottomNavigationBar: Obx(
        () => CustomBottomNavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onTap: controller.updateIndex,
          items: bottomNavItems,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOrderStats(),
              const SizedBox(height: 24),
              _buildRecentReviews(),
              const SizedBox(height: 24),
              _buildReport(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderStats() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Get.bottomSheet(
                const RunningOrdersSheet(),
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
              );
            },
            child: _buildStatCard(
              '10',
              'Running Orders',
              AppColors.backgroundAccent,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Get.bottomSheet(
                const PendingOrderSheet(),
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
              );
            },
            child: _buildStatCard(
              '07',
              'Pending Orders',
              AppColors.backgroundAccent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String number, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextHeading9(
              text: 'Recent Review',
            ),
            TextButton(
              onPressed: () {},
              child: const TextButton1(
                text: 'View All',
                color: AppColors.primaryBase,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildReviewCard(),
      ],
    );
  }

  Widget _buildReviewCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/profile_image.png'),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sami Ahmed',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Jun 1,2021',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: List.generate(
                  5,
                  (index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Great place to stay. Food quality is good.\nServices are good. Overall value for money.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextHeading9(
              text: 'Your Report',
            ),
            Row(
              children: const [
                Icon(Icons.calendar_today, color: Colors.purple, size: 20),
                SizedBox(width: 8),
                TextButton1(
                  text: "30 Oct",
                  color: AppColors.primaryBase,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: LineChart(
            curve: Curves.linear,
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  axisNameSize: 40,
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    reservedSize: 24,
                    getTitlesWidget: (value, meta) {
                      if (value < 0 || value > 6) return const Text('');
                      const titles = [
                        'Sat',
                        'Sun',
                        'Mon',
                        'Tue',
                        'Wed',
                        'Thr',
                        'Fri'
                      ];
                      return Text(
                        titles[value.toInt()],
                        style: CustomResponsiveTextStyles.paragraph6.copyWith(
                          color: AppColors.textSecondaryBase,
                        ),
                      );
                    },
                  ),
                ),
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              minX: 0, // Add this to set the x-axis range
              maxX: 6, // Add this to set the x-axis range

              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    const FlSpot(0, 2),
                    const FlSpot(1, 1),
                    const FlSpot(2, 3),
                    const FlSpot(3, 5),
                    const FlSpot(4, 3),
                    const FlSpot(5, 4),
                    const FlSpot(6, 4),
                  ],
                  isCurved: true,
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF793AFF), // 0%
                      Color(0xFF631FFD), // 39%
                      Color(0xFF4BFF96), // 100%
                    ],
                    stops: [
                      0.0, // 0%
                      0.1, // 39%
                      1.0, // 100%
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  curveSmoothness: 0.39,
                  barWidth: 6,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: false,
                    color: AppColors.surfaceLight,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF793AFF), // 0%
                        Color(0xFF631FFD), // 39%
                        Color(0xFF4BFF96), // 100%
                      ],
                      stops: [
                        0.0, // 0%
                        0.39, // 39%
                        1.0, // 100%
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', true),
          _buildNavItem(Icons.pie_chart, 'Balance', false),
          _buildFloatingNavButton(),
          _buildNavItem(Icons.list_alt, 'Food List', false),
          _buildNavItem(Icons.person_outline, 'Profile', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? Colors.purple : Colors.grey,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.purple : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingNavButton() {
    return Container(
      height: 56,
      width: 56,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.purple,
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 32,
      ),
    );
  }
}
