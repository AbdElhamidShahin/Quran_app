import 'package:dio/dio.dart';

class PrayerService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.aladhan.com/v1'));

  Future<Map<String, String>> fetchPrayerTimes(double lat, double lng) async {
    try {
      final response = await _dio.get('/timings', queryParameters: {
        'latitude': lat,
        'longitude': lng,
        'method': 2,
      });

      if (response.statusCode == 200) {
        final data = response.data['data']['timings'];

        const List<String> prayerOrder = [
          'الفجر',
          'الظهر',
          'العصر',
          'المغرب',
          'العشاء',
        ];

        const Map<String, String> prayerKeys = {
          'الفجر': 'Fajr',
          'الظهر': 'Dhuhr',
          'العصر': 'Asr',
          'المغرب': 'Maghrib',
          'العشاء': 'Isha',
        };

        Map<String, String> prayerTimes = {};

        for (var prayer in prayerOrder) {
          final prayerKey = prayerKeys[prayer];
          if (prayerKey != null && data.containsKey(prayerKey)) {
            prayerTimes[prayer] = data[prayerKey];
          } else {
            prayerTimes[prayer] = 'غير متوفر';
          }
        }

        return prayerTimes;
      } else {
        throw 'حدث خطأ أثناء جلب البيانات: ${response.statusCode}';
      }
    } catch (e) {
      throw 'حدث خطأ أثناء جلب مواقيت الصلاة: $e';
    }
  }
}
