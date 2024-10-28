import 'package:frontend/models/event_categories_enum.dart';

class HotelDemography {
  Map<String, double> nationalityCount;
  Map<String, double> ageGroupCount;
  Map<EventCategory, double> eventInterestCount;

  HotelDemography(this.nationalityCount, this.ageGroupCount, this.eventInterestCount);

  List<MapEntry<String, double>> getTopNationalities() {
    var sorted = nationalityCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(3).toList(); // This will properly return only top 3
  }

  // Same fix should be applied to other similar methods:
  List<MapEntry<String, double>> getTopAgeGroups() {
    var sorted = ageGroupCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(3).toList();
  }

  List<MapEntry<EventCategory, double>> getTopEventInterests() {
    var sorted = eventInterestCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(3).toList();
  }
}