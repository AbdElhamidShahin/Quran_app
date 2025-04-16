import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../model/PrayerTime.dart';
import '../../model/bloc/bloc.dart';
import '../../model/bloc/states.dart';
import '../wedgit/buildErrorWidget.dart';

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
        FetchPrayerTimes(lat: 0, lng: 0), // يمكنك التعامل معها بطريقة أخرى أيضًا
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
      appBar: AppBar(title: const Text('مواقيت الصلاة')),
      body: BlocBuilder<PrayerBloc, PrayerState>(
        builder: (context, state) {
          if (state is PrayerLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PrayerLoadedState) {
            return ListView(
              children: state.times.entries
                  .map((entry) => ListTile(
                title: Text(entry.key),
                trailing: Text(entry.value),
              ))
                  .toList(),
            );
          } else if (state is PrayerErrorState) {
            return buildErrorWidget(state.message,);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
