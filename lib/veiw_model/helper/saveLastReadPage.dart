import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>?> getLastReadPage() async {
  final prefs = await SharedPreferences.getInstance();
  final int? page = prefs.getInt('last_read_page');
  final int? surah = prefs.getInt('last_read_surah');
  final String? surahName = prefs.getString('last_read_surah_name');

  if (page != null && surah != null && surahName != null) {
    return {
      'page': page,
      'surah': surah,
      'surahName': surahName,
    };
  } else {
    return null;
  }
}
