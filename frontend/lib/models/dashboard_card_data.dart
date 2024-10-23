// data_model.dart

class DashboardCardData {
  final String title;
  final String mainValue;
  final String subtitle;
  final String
      graphType; // Can be 'bar', 'line', or 'wave' for different graph styles
  final List<String> graphColors;

  const DashboardCardData({
    required this.title,
    required this.mainValue,
    required this.subtitle,
    required this.graphType,
    required this.graphColors,
  });
}
