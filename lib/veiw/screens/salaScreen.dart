import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../model/PrayerTime.dart';
import '../../model/bloc/bloc.dart';
import '../../model/bloc/states.dart';
import '../../veiw_model/helper/Position/getPosition.dart';
import '../wedgit/buildLoadingShimmer.dart';
import '../wedgit/buildPrayerTimesUI.dart'; // استيراد الـ BLoC الصحيح

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  String nextPrayerName = '';
  Duration remainingTime = Duration.zero;
  late Timer _timer;
  Map<String, String> _prayerTimes = {};

  @override
  void initState() {
    super.initState();
    fetchData();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (nextPrayerName.isNotEmpty) {
        _calculateNextPrayerTimes();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final position = await getPosition();
      context.read<PrayerBloc>().add(
        FetchPrayerTimes(lat: position.latitude, lng: position.longitude),
      );
    } catch (e) {
      context.read<PrayerBloc>().add(
        FetchPrayerTimes(lat: 30.0444, lng: 31.2357), // افتراضياً القاهرة
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }


  void _calculateNextPrayerTimes() {
    final now = DateTime.now();
    DateTime? nextPrayerDateTime;
    String nextPrayer = '';

    final prayersInOrder = [
      {'name': 'الفجر', 'time': _prayerTimes['الفجر']},
      {'name': 'الظهر', 'time': _prayerTimes['الظهر']},
      {'name': 'العصر', 'time': _prayerTimes['العصر']},
      {'name': 'المغرب', 'time': _prayerTimes['المغرب']},
      {'name': 'العشاء', 'time': _prayerTimes['العشاء']},
    ];

    for (final prayer in prayersInOrder) {
      final timeStr = prayer['time'];
      if (timeStr == null) continue;

      try {
        final timeParts = timeStr.split(':');
        final hour = int.parse(timeParts[0]);
        final minute = int.parse(timeParts[1]);

        var prayerDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          hour,
          minute,
        );

        if (prayerDateTime.isBefore(now)) {
          if (prayer['name'] == 'العشاء') {
            final fajrTime = prayersInOrder[0]['time']?.split(':');
            if (fajrTime != null && fajrTime.length == 2) {
              final fajrHour = int.parse(fajrTime[0]);
              final fajrMinute = int.parse(fajrTime[1]);
              prayerDateTime = DateTime(
                now.year,
                now.month,
                now.day + 1,
                fajrHour,
                fajrMinute,
              );
              nextPrayer = prayersInOrder[0]['name']!;
              nextPrayerDateTime = prayerDateTime;
              break;
            }
          }
          continue;
        }

        if (nextPrayerDateTime == null ||
            prayerDateTime.isBefore(nextPrayerDateTime)) {
          nextPrayerDateTime = prayerDateTime;
          nextPrayer = prayer['name']!;
        }
      } catch (e) {
        debugPrint('Error parsing prayer time: $e');
      }
    }

    if (nextPrayerDateTime != null) {
      setState(() {
        nextPrayerName = nextPrayer;
        remainingTime = nextPrayerDateTime!.difference(now);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مواقيت الصلاة'), centerTitle: true),
      body: BlocBuilder<PrayerBloc, PrayerState>(
        builder: (context, state) {
          if (state is PrayerLoadingState) {
            return  Center(child: buildLoadingShimmer());
          } else if (state is PrayerLoadedState) {
            if (_prayerTimes != state.times) {
              _prayerTimes = state.times;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _calculateNextPrayerTimes();
              });
            }
            return buildPrayerTimesUI(
              state.times,
              nextPrayerName,
              remainingTime,
            );
          } else if (state is PrayerErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/Animation - 1745055052923.json', width: 250, height: 250),
                  const SizedBox(height: 20),
                  const Text(
                    'لا يوجد اتصال بالإنترنت',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'يرجى التحقق من الشبكة والمحاولة مرة أخرى',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return  Center(

            child: buildLoadingShimmer(),
          );
        },
      ),
    );
  }
}
