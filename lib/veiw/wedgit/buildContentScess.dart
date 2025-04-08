import 'package:flutter/material.dart';
import '../../model/item.dart';
Widget buildContentSuccess(
    BuildContext context,
    List<Item> pages,
    String surahName, {
      String? surahNameEn,
      String? transliteration,
    }) {
  return PageView.builder(
    controller: PageController(viewportFraction: 1.1), // كل صفحة تأخذ 92% من العرض
    scrollDirection: Axis.horizontal,
    reverse: true,
    itemCount: pages.length,
    itemBuilder: (context, index) {
      final page = pages[index];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0), // هامش 8 بكسل
        child: Image.asset(
          page.imageUrl,
          width: double.infinity,      // يملأ العرض المتاح
          fit: BoxFit.fitWidth,        // يناسب العرض بدون قص
          errorBuilder: (ctx, err, _) => Container(
            color: Colors.grey[200],
            child: const Center(child: Icon(Icons.image_not_supported)),
          ),
        ),
      );
    },
  );
}
