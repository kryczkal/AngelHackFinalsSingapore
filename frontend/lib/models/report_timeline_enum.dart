enum ReportTimeline {
  week(label: '1 week', period: '7d', periodInDays: 7),
  month(label: '1 month', period: '30d', periodInDays: 30),
  sixMonths(label: '6 months', period: '180d', periodInDays: 180),
  ;

  final String label;
  final String period;
  final int periodInDays;

  const ReportTimeline({
    required this.label,
    required this.period,
    required this.periodInDays,
  });
}
