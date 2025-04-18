import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../../model/PrayerTime.dart';
import '../../model/bloc/bloc.dart';
import '../../model/bloc/states.dart'; // استيراد الـ BLoC الصحيح

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
    _fetchData();
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

  Future<void> _fetchData() async {
    try {
      final position = await _getPosition();
      context.read<PrayerBloc>().add(
        FetchPrayerTimes(lat: position.latitude, lng: position.longitude),
      );
    } catch (e) {
      context.read<PrayerBloc>().add(
        FetchPrayerTimes(lat: 30.0444, lng: 31.2357), // افتراضياً القاهرة
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<Position> _getPosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw 'يجب تفعيل خدمة الموقع';
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'تم رفض إذن الوصول للموقع';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'تم رفض إذن الموقع بشكل دائم، يرجى تفعيله من الإعدادات';
    }

    return await Geolocator.getCurrentPosition();
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

        var prayerDateTime = DateTime(now.year, now.month, now.day, hour, minute);

        if (prayerDateTime.isBefore(now)) {
          if (prayer['name'] == 'العشاء') {
            final fajrTime = prayersInOrder[0]['time']?.split(':');
            if (fajrTime != null && fajrTime.length == 2) {
              final fajrHour = int.parse(fajrTime[0]);
              final fajrMinute = int.parse(fajrTime[1]);
              prayerDateTime = DateTime(now.year, now.month, now.day + 1, fajrHour, fajrMinute);
              nextPrayer = prayersInOrder[0]['name']!;
              nextPrayerDateTime = prayerDateTime;
              break;
            }
          }
          continue;
        }

        if (nextPrayerDateTime == null || prayerDateTime.isBefore(nextPrayerDateTime)) {
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
      appBar: AppBar(
        title: const Text('مواقيت الصلاة'),
        centerTitle: true,
      ),
      body: BlocBuilder<PrayerBloc, PrayerState>(
        builder: (context, state) {
          if (state is PrayerLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PrayerLoadedState) {
            if (_prayerTimes != state.times) {
              _prayerTimes = state.times;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _calculateNextPrayerTimes();
              });
            }
            return _buildPrayerTimesUI(state.times);
          } else if (state is PrayerErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _fetchData,
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildPrayerTimesUI(Map<String, String> times) {
    final orderedPrayers = [
      {'name': 'العشاء', 'time': times['العشاء'] ?? '--:--'},
      {'name': 'المغرب', 'time': times['المغرب'] ?? '--:--'},
      {'name': 'العصر', 'time': times['العصر'] ?? '--:--'},
      {'name': 'الظهر', 'time': times['الظهر'] ?? '--:--'},
      {'name': 'الفجر', 'time': times['الفجر'] ?? '--:--'},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'الوقت الحالي',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DateFormat('hh:mm a').format(DateTime.now()),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'متبقي حتى صلاة $nextPrayerName',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${remainingTime.inHours.toString().padLeft(2, '0')}:${(remainingTime.inMinutes % 60).toString().padLeft(2, '0')}:${(remainingTime.inSeconds % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: orderedPrayers.length,
              itemBuilder: (context, index) {
                final prayer = orderedPrayers[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(
                      prayer['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    trailing: Text(
                      prayer['time']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
