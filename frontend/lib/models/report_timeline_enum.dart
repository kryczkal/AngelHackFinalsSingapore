enum ReportTimeline {
  week(label: '1 week', period: '7d'),
  month(label: '1 month', period: '30d'),
  sixMonths(label: '6 months', period: '180d');

  final String label;
  final String period;

  const ReportTimeline({
    required this.label,
    required this.period,
  });
}
