import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'item.dart';

Future<List<Item>> fetchSuraDetails() async {
  final String response = await rootBundle.loadString('assets/pagesQuran.json');
  final List<dynamic> data = json.decode(response) as List<dynamic>;

  // خريطة تجمع عدد الآيات لكل سورة
  final Map<int, int> versesCountMap = {};
  // خريطة تجمع صفحات كل سورة عشان نختار أقل صفحة كـ 'page'
  final Map<int, int> firstPageMap = {};
  // خريطة لحفظ الـ JSON الخاص بأول صفحة (لبناء الـ Item)
  final Map<int, Map<String, dynamic>> firstPageJsonMap = {};

  for (var page in data) {
    final sn = page['start']['surah_number'] as int;
    final sv = page['start']['verse'] as int;
    final ev = page['end']['verse'] as int;
    final count = ev - sv + 1;

    // جمع الآيات
    versesCountMap[sn] = (versesCountMap[sn] ?? 0) + count;

    // تحديد أول صفحة (أقل رقم)
    final pg = page['page'] as int;
    if (!firstPageMap.containsKey(sn) || pg < firstPageMap[sn]!) {
      firstPageMap[sn] = pg;
      firstPageJsonMap[sn] = page as Map<String, dynamic>;
    }
  }

  // بناء الـ Item لكل سورة
  final List<Item> surahList = [];
  versesCountMap.forEach((sn, totalCount) {
    final jsonPage = firstPageJsonMap[sn]!;
    final item = Item.fromJson(jsonPage);
    item.versesCount = totalCount; // هنا عدد الآيات الصحيح
    surahList.add(item);
  });

  // لو حابب ترتب حسب رقم السورة
  surahList.sort((a, b) => a.surahNumber.compareTo(b.surahNumber));
  return surahList;
}


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
