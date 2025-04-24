import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import '../../model/JsonScreen.dart';
import '../../model/item.dart';

Future<void> saveLastReadPage(int pageNumber) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('lastReadPage', pageNumber);
}

Future<int?> getLastReadPage() async {
  final prefs = await SharedPreferences.getInstance();
  int? page = prefs.getInt('lastReadPage');
  print('Last read page from storage: $page');
  return page;
}

Future<Map<String, dynamic>> getSurahInfoByPage(int pageNumber) async {
  final String response = await rootBundle.loadString('assets/pagesQuran.json');
  final List<dynamic> data = json.decode(response);

  print('Data loaded from JSON: $data'); // إضافة سجلات للطباعة هنا

  for (var page in data) {
    if (page['page'] == pageNumber) {
      final start = page['start'];
      return {
        'surahNumber': start['surah_number'],
        'surahNameAr': start['surah_name_ar'],
      };
    }
  }

  throw Exception('لم يتم العثور على معلومات السورة للصفحة $pageNumber');
}
Future<Item?> getLastReadSura() async {
  final prefs = await SharedPreferences.getInstance();
  final surahNumber = prefs.getInt('last_read_surah');

  if (surahNumber != null) {
    final suras = await fetchSuraDetails(); // بترجع List<Item>
    try {
      return suras.firstWhere(
            (sura) => sura.surahNumber == surahNumber,
      );
    } catch (e) {
      return null;
    }
  }
  return null;
}
