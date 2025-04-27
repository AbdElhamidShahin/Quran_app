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
  final int count;

  addNumberState({required this.count});
}

class resultcountState extends PrayerState {
  final int count;

  resultcountState({required this.count});
}

class PrayerInitialState extends PrayerState {}

abstract class PrayerTimesState {}

class PrayerTimesInitial extends PrayerTimesState {}

class PrayerTimesLoading extends PrayerTimesState {}

class PrayerTimesLoaded extends PrayerTimesState {
  final Map<String, String> prayerTimes;
  final String nextPrayerName;
  final Duration remainingTime;
  final bool isAdhanPlaying;

  PrayerTimesLoaded({
    required this.prayerTimes,
    required this.nextPrayerName,
    required this.remainingTime,
    this.isAdhanPlaying = false,
  });
}

class PrayerTimesError extends PrayerTimesState {
  final String message;

  PrayerTimesError(this.message);
}

class AdhanPlayingState extends PrayerState {}

class AdhanStoppedState extends PrayerState {}
