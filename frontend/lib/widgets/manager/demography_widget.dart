import 'package:flutter/material.dart';
import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/models/hotel_demography.dart';

class HotelDemographyCard extends StatelessWidget {
  final HotelDemography hotelDemography;

  const HotelDemographyCard({
    super.key,
    required this.hotelDemography,
  });

  List<String> mapEntryToStringList(List<MapEntry<String, double>> entries) {
    return entries
        .map((entry) => '${entry.key}: ${entry.value}%')
        .toList();
  }

  List<String> eventToStringList(List<MapEntry<EventCategory, double>> entries) {
    return entries
        .map((entry) => '${entry.key.name}: ${entry.value}%')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.hotel,
                  color: Colors.blue.shade700,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Hotel demography',
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Stats
          Column(
            children: [
              _buildStatCard(
                icon: Icons.public,
                title: 'Guest nationalities',
                demographics: mapEntryToStringList(
                    hotelDemography.getTopNationalities()),
              ),
              const SizedBox(height: 12),
              _buildStatCard(
                icon: Icons.group,
                title: 'Guest age group',
                demographics: mapEntryToStringList(
                    hotelDemography.getTopAgeGroups()),
              ),
              const SizedBox(height: 12),
              _buildStatCard(
                icon: Icons.event,
                title: 'Event categories',
                demographics: eventToStringList(
                    hotelDemography.getTopEventInterests()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required List<String> demographics,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.blue.shade700,
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildDemographics(demographics),
        ],
      ),
    );
  }

  Widget _buildDemographics(List<String> topDemographics) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: topDemographics.map((demo) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.blue.shade100,
              width: 1,
            ),
          ),
          child: Text(
            demo,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }
}