import 'package:shared_preferences/shared_preferences.dart';
import 'package:quran_app/model/item.dart';
import 'package:quran_app/model/JsonScreen.dart';

Future<int?> getLastReadPage() async {
  final prefs = await SharedPreferences.getInstance();
  int? page = prefs.getInt('last_read_page');
  return page ?? 700; // fallback
}

Future<Item?> getLastReadSura() async {
  final prefs = await SharedPreferences.getInstance();
  final surahNumber = prefs.getInt('last_read_surah');
  if (surahNumber != null) {
    final suras = await fetchSuraDetails();
    try {
      return suras.firstWhere((sura) => sura.surahNumber == surahNumber);
    } catch (e) {
      print("Error finding surah: $e");
      return null;
    }
  }
  return null;
}

Future<void> saveLastReadPage(int pageNumber, int surahNumber) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('last_read_page', pageNumber);
  await prefs.setInt('last_read_surah', surahNumber);
}
