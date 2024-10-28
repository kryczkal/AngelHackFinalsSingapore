import 'package:flutter/material.dart';
import 'package:frontend/models/event_suggestion_data.dart';
import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/models/hotel_demography.dart';
import 'package:frontend/widgets/misc/scroll_behavior_web_extended.dart';
import 'package:frontend/widgets/misc/single_child_scroll_view_web_extended.dart';

class HotelDemographyCard extends StatefulWidget {
  final HotelDemography hotelDemography;

  const HotelDemographyCard({
    super.key,
    required this.hotelDemography,
  });

  @override
  State<HotelDemographyCard> createState() => _HotelDemographyCardState();
}

class _HotelDemographyCardState extends State<HotelDemographyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.hotel,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current hotel demography',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text(
                      'Biggest guest nationality: ',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      widget.hotelDemography.getTopNationality()!.key,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [const Text(
                    'Top guest age group: ',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                      widget.hotelDemography.getTopAgeGroup()!.key,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ]
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemographics(List<String> demo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: demo.map((demo) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                demo,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
