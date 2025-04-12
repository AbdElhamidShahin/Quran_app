import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Map<String, dynamic> pagesQuran = {};
Map<String, dynamic> allSurahs = {};

Future<void> loadQuranData() async {
  try {
    final pagesJsonString = await rootBundle.loadString('assets/json/pagesQuran.json');
    final surahsJsonString = await rootBundle.loadString('assets/json/allSurahs.json');
    pagesQuran = json.decode(pagesJsonString);
    allSurahs = json.decode(surahsJsonString);
  } catch (e) {
    debugPrint('Error loading Quran data: $e');
  }
}

Map<String, dynamic> getSurahInfoByPage(int page) {
  // إذا كانت الصفحة موجودة، إرجاع بياناتها
  final pageKey = page.toString();
  if (pagesQuran.containsKey(pageKey)) {
    final surahNumber = pagesQuran[pageKey]['surah'];
    final surahName = allSurahs[surahNumber.toString()]['name'];
    return {
      'surahNumber': surahNumber,
      'surahNameAr': surahName,
    };
  }

  // إذا كانت الصفحة غير موجودة، البحث عن أقرب صفحة أصغر (أو أكبر)
  final nearestPage = pagesQuran.keys
      .map((k) => int.parse(k))
      .toList()
      .reduce((a, b) => (a - page).abs() < (b - page).abs() ? a : b);

  final surahNumber = pagesQuran[nearestPage.toString()]['surah'];
  final surahName = allSurahs[surahNumber.toString()]['name'];
  return {
    'surahNumber': surahNumber,
    'surahNameAr': surahName,
  };
}

Future<int?> getLastReadPage() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('last_read_page');
}