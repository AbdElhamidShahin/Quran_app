import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'item.dart';

// تجيب أول صفحة لكل سورة (زي ما هو)
Future<List<Item>> fetchSuraDetails() async {
  try {
    final String response = await rootBundle.loadString('assets/pagesQuran.json');
    final List<dynamic> data = json.decode(response) as List<dynamic>;

    final Map<int, Item> surahMap = {};

    for (var page in data) {
      final surahNumber = page['start']['surah_number'] as int;

      if (!surahMap.containsKey(surahNumber)) {
        surahMap[surahNumber] = Item.fromJson(page);
      }
    }

    return surahMap.values.toList();
  } catch (e) {
    debugPrint('Error loading Quran data: $e');
    return [];
  }
}

// ✅ دالة جديدة: تجيب كل الصفحات الخاصة بالسورة
Future<List<Item>> fetchQuranPagesBySurah(int surahNumber) async {
  try {
    final response = await rootBundle.loadString('assets/pagesQuran.json');
    final List<dynamic> data = json.decode(response) as List<dynamic>;

    final List<Item> result = [];

    for (var page in data) {
      final startSurah = page['start']['surah_number'] as int;
      final endSurah = page['end']['surah_number'] as int;

      if (startSurah == surahNumber || endSurah == surahNumber) {
        result.add(Item.fromJson(page));
      }
    }

    return result;
  } catch (e) {
    debugPrint('Error fetching Quran pages: $e');
    return [];
  }
}
