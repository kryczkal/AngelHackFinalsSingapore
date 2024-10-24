import 'package:flutter/material.dart';
import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/widgets/misc/scroll_behavior_web_extended.dart';

class ManagerCategoryRankingPage extends StatelessWidget {
  final List<(double, EventCategory)> categoryRatings;

  const ManagerCategoryRankingPage({
    super.key,
    required this.categoryRatings,
  });

  @override
  Widget build(BuildContext context) {
    final ratingsMap = Map.fromEntries(
      categoryRatings.map((rating) => MapEntry(rating.$2, rating.$1)),
    );

    final sortedCategories = EventCategory.values
        .where((category) => category != EventCategory.all)
        .map((category) => (
              ratingsMap[category] ?? -1.0,
              category,
              ratingsMap.containsKey(category)
            ))
        .toList()
      ..sort((a, b) {
        if (a.$1 == -1.0 && b.$1 == -1.0) {
          return a.$2.name.compareTo(b.$2.name);
        }
        if (a.$1 == -1.0) return 1;
        if (b.$1 == -1.0) return -1;
        return b.$1.compareTo(a.$1);
      });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehaviorWebExtended().copyWith(scrollbars: false),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Overall Statistics',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                      ),
                      Icon(Icons.more_horiz, color: Colors.grey.shade600),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (categoryRatings.isNotEmpty) ...[
                    _buildStatItem(
                      'Top Category',
                      '${_formatCategoryName(sortedCategories.first.$2.name)} (${sortedCategories.first.$1.toStringAsFixed(1)})',
                    ),
                    const SizedBox(height: 8),
                    _buildStatItem(
                      'Average Rating',
                      '${(categoryRatings.map((e) => e.$1).reduce((a, b) => a + b) / categoryRatings.length).toStringAsFixed(1)}/5.0',
                    ),
                    const SizedBox(height: 8),
                    _buildStatItem(
                      'Rated Categories',
                      '${categoryRatings.length}/${EventCategory.values.length - 1}',
                    ),
                  ],
                ],
              ),
            ),
            ...sortedCategories.map((item) {
              final (rating, category, hasRating) = item;
              final displayRating = hasRating ? rating : -1.0;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: hasRating
                            ? _getRatingColor(rating).withOpacity(0.1)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        category.icon,
                        color:
                            hasRating ? _getRatingColor(rating) : Colors.grey,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatCategoryName(category.name),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            hasRating ? 'Active category' : 'No events yet',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: hasRating
                            ? _getRatingColor(rating).withOpacity(0.1)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        hasRating ? rating.toStringAsFixed(1) : 'N/A',
                        style: TextStyle(
                          color:
                              hasRating ? _getRatingColor(rating) : Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  String _formatCategoryName(String name) {
    if (name == 'artificialIntelligence') return 'AI';

    final words = name.replaceAllMapped(
      RegExp(r'(?<!^)(?=[A-Z])'),
      (match) => ' ',
    );
    return words.split(' ').map((word) {
      return word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  Color _getRatingColor(double rating) {
    if (rating >= 4.0) return Colors.green;
    if (rating >= 3.0) return Colors.blue;
    if (rating >= 2.0) return Colors.orange;
    return Colors.red;
  }
}
