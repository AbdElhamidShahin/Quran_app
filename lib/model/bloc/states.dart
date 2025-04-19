abstract class PrayerState {}

class PrayerInitial extends PrayerState {}

class PrayerLoadingState extends PrayerState {}

class PrayerLoadedState extends PrayerState {
  final Map<String, String> times;

  PrayerLoadedState(this.times);
}

class PrayerErrorState extends PrayerState {
  final String message;

  PrayerErrorState(this.message);
}
class addNumberState extends PrayerState {

 final int count ;

  addNumberState({required this.count});


}
class resultcountState extends PrayerState {

  final int count ;

  resultcountState({required this.count});


}
