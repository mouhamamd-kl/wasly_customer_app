import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class InteractivePriceRange extends StatefulWidget {
  final double minPrice;
  final double maxPrice;
  final Function(double, double) onChanged;

  const InteractivePriceRange({
    Key? key,
    required this.minPrice,
    required this.maxPrice,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<InteractivePriceRange> createState() => _InteractivePriceRangeState();
}

class _InteractivePriceRangeState extends State<InteractivePriceRange>
    with SingleTickerProviderStateMixin {
  late double _lowerValue;
  late double _upperValue;

  // Price distribution data (price points and their frequency)
  final List<PricePoint> priceData = [
    PricePoint(20, 15),
    PricePoint(40, 25),
    PricePoint(60, 18),
    PricePoint(80, 12),
    PricePoint(100, 8),
  ];

  @override
  void initState() {
    super.initState();
    _lowerValue = widget.minPrice;
    _upperValue = widget.maxPrice;
  }

  bool isBarInRange(double price) {
    return price >= _lowerValue && price <= _upperValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Price Range',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE9D5FF).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '\$${_lowerValue.toInt()} - \$${_upperValue.toInt()}',
                  style: const TextStyle(
                    color: Color(0xFF8B5CF6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class PricePoint {
  final double price;
  final double frequency;

  PricePoint(this.price, this.frequency);
}
