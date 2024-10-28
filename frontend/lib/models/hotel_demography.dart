import 'package:frontend/models/event_categories_enum.dart';

class HotelDemography {
  Map<String, int> nationalityCount;
  Map<String, int> ageGroupCount;
  Map<EventCategory, int> eventInterestCount;

  HotelDemography(this.nationalityCount, this.ageGroupCount, this.eventInterestCount);

  List<MapEntry<String, int>> getTopNationalities() {
    var sorted = nationalityCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(3).toList(); // This will properly return only top 3
  }

  // Same fix should be applied to other similar methods:
  List<MapEntry<String, int>> getTopAgeGroups() {
    var sorted = ageGroupCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(3).toList();
  }

  List<MapEntry<EventCategory, int>> getTopEventInterests() {
    var sorted = eventInterestCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(3).toList();
  }
}