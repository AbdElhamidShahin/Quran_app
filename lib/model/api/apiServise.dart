import 'package:dio/dio.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class PrayerService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.aladhan.com/v1'));

  PrayerService() {
    tz.initializeTimeZones();
  }

  Future<Map<String, String>> fetchPrayerTimes(double lat, double lng) async {
    try {
      final date = DateTime.now().toString().split(' ').first;

      final timezone = tz.local.name;

      final res = await _dio.get('/timings/$date', queryParameters: {
        'latitude': lat,
        'longitude': lng,
        'method': 5, // الهيئة المصرية
        'school': 1,
        'timezonestring': timezone,
      });

      final timings = res.data['data']['timings'] as Map<String, dynamic>;

      return {
        'الفجر': timings['Fajr'],
        'الظهر': timings['Dhuhr'],
        'العصر': timings['Asr'],
        'المغرب': timings['Maghrib'],
        'العشاء': timings['Isha'],
      };
    } catch (e) {
      throw 'خطأ أثناء جلب المواقيت: $e';
    }
  }
}
