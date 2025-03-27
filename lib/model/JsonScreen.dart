import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'Item.dart';

Future<List<Item>> fetchTravelFromJson(
    BuildContext context,
    String category,
    ) async {
  try {
    final String response = await rootBundle.loadString('assets/quran.json');
    final Map<String, dynamic> data = json.decode(response);

    if (data.containsKey(category)) {
      final List<dynamic> categoryData = data[category] as List<dynamic>;
      return categoryData.map((json) => Item.fromJson(json)).toList();
    } else {
      debugPrint('الفئة "$category" غير موجودة في البيانات.');
      return [];
    }
  } catch (e) {
    debugPrint('خطأ أثناء تحميل البيانات: $e');
    return [];
  }
}
