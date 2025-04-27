
abstract class PrayerEvent {}

class FetchPrayerTimes extends PrayerEvent {
  final double lat;
  final double lng;

  FetchPrayerTimes({required this.lat, required this.lng});
}
