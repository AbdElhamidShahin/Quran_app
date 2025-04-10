import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

late Map<String, dynamic> pagesQuran;
late Map<String, dynamic> allSurahs;
Map<String, dynamic> getSurahInfoByPage(
    int page,
    Map<String, dynamic> pagesQuran,
    Map<String, dynamic> allSurahs,
    ) {
  final pageKey = page.toString();

  if (pagesQuran.containsKey(pageKey)) {
    final surahNumber = pagesQuran[pageKey]['surah'];
    final surahName = allSurahs[surahNumber.toString()]['name'];
    return {
      'surahNumber': surahNumber,
      'surahNameAr': surahName,
    };
  }

  return {
    'surahNumber': 1,
    'surahNameAr': 'الفاتحة',
  };
}

Future<void> loadQuranData() async {
  final pagesJsonString = await rootBundle.loadString('assets/json/pagesQuran.json');
  final surahsJsonString = await rootBundle.loadString('assets/json/allSurahs.json');

  pagesQuran = json.decode(pagesJsonString);
  allSurahs = json.decode(surahsJsonString);
}

Future<int?> getLastReadPage() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('last_read_page');
}

Future<Map<String, dynamic>?> getLastReadData() async {
  final prefs = await SharedPreferences.getInstance();
  final page = prefs.getInt('last_read_page');
  final surahNumber = prefs.getInt('last_read_surah');
  final surahName = prefs.getString('last_read_surah_name');

  if (page != null && surahNumber != null && surahName != null) {
    return {
      'page': page,
      'surahNumber': surahNumber,
      'surahName': surahName,
    };
  }
  return null;
}

