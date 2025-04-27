import 'package:dio/dio.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../PrayerTime.dart';

class PrayerService {
  final Dio _dio;
  final AudioPlayer _audioPlayer = AudioPlayer();

  PrayerService({Dio? dio}) : _dio = dio ?? Dio(BaseOptions(
    baseUrl: 'https://api.aladhan.com/v1',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));

  Future<Map<String, String>> fetchPrayerTimes(double lat, double lng) async {
    try {
      final response = await _dio.get('/timings', queryParameters: {
        'latitude': lat,
        'longitude': lng,
        'method': 2,
      });

      if (response.statusCode == 200) {
        return _parsePrayerTimes(response.data['data']['timings']);
      }
      throw 'خطأ في الاستجابة: ${response.statusCode}';
    } catch (e) {
      throw 'فشل في جلب مواقيت الصلاة: $e';
    }
  }
  Future<void> playAdhan(String prayerName) async {
    await _audioPlayer.play(AssetSource('assets/4032.mp3'));
  }
  void dispose() {
    _audioPlayer.dispose();
  }

  Map<String, String> _parsePrayerTimes(Map<String, dynamic> timings) {
    const prayerMapping = {
      'الفجر': 'Fajr',
      'الظهر': 'Dhuhr',
      'العصر': 'Asr',
      'المغرب': 'Maghrib',
      'العشاء': 'Isha',
    };

    final result = <String, String>{};
    prayerMapping.forEach((key, value) {
      result[key] = timings[value] ?? '--:--';
    });
    return result;
  }
}