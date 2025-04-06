// model/JsonScreen.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'item.dart';

Future<List<Item>> fetchSuraDetails() async {
  try {
    final String response = await rootBundle.loadString('assets/pagesQuran.json');
    final List<dynamic> data = json.decode(response) as List<dynamic>;

    // Create a map to store unique surahs
    final Map<int, Item> surahMap = {};

    for (var page in data) {
      final surahNumber = page['start']['surah_number'] as int;

      // Only add if we haven't seen this surah before
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



Future<List<Item>> fetchQuranPages(int startPage) async {
  try {
    final String response = await rootBundle.loadString('assets/pagesQuran.json');
    final List<dynamic> data = json.decode(response) as List<dynamic>;

    return data
        .where((page) => page['page'] == startPage)
        .map<Item>((page) => Item.fromJson(page)) // تحديد نوع الإرجاع صراحةً
        .toList();
  } catch (e) {
    debugPrint('Error fetching Quran pages: $e');
    return [];
  }
}