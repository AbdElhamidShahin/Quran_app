import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../../model/PrayerTime.dart';
import '../../model/bloc/bloc.dart';
import '../../model/bloc/states.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final position = await _getPosition();
      context.read<PrayerBloc>().add(
        FetchPrayerTimes(
          lat: position.latitude,
          lng: position.longitude,
        ),
      );
    } catch (e) {
      context.read<PrayerBloc>().add(
        FetchPrayerTimes(lat: 30.0444, lng: 31.2357), // القاهرة كموقع افتراضي
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
    // ترتيب الصلوات كما في الصورة
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
          // البطاقة العلوية
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
                  const Text(
                    'متبقي حتى صلاة المغرب',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '01:48:54',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // قائمة مواقيت الصلاة
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