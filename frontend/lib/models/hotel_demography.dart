import 'package:frontend/models/event_categories_enum.dart';

class HotelDemography {
  // Map to store number of guests per nationality
  Map<String, int> nationalityCount;

  // Map to store number of guests per age group
  Map<String, int> ageGroupCount;

  Map<EventCategory, int> eventInterestCount;

  // Constructor that takes both maps as arguments
  HotelDemography(this.nationalityCount, this.ageGroupCount, this.eventInterestCount);

  // Method to get total number of guests
  int getTotalGuests() {
    return nationalityCount.values.fold(0, (sum, count) => sum + count);
  }

  MapEntry<String, int>? getTopNationality() {
    if (nationalityCount.isEmpty) return null;
    return nationalityCount.entries.reduce((a, b) => a.value > b.value ? a : b);
  }

  MapEntry<String, int>? getTopAgeGroup() {
    if (ageGroupCount.isEmpty) return null;
    return ageGroupCount.entries.reduce((a, b) => a.value > b.value ? a : b);
  }

  MapEntry<EventCategory, int>? getTopEventInterest() {
    if (eventInterestCount.isEmpty) return null;
    return eventInterestCount.entries.reduce((a, b) => a.value > b.value ? a : b);
  }
}