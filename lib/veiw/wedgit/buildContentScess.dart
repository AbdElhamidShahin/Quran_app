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
    scrollDirection: Axis.horizontal,
    reverse: true,
    itemCount: pages.length,
    itemBuilder: (context, index) {
      final page = pages[index];
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded( // 👈 ده يخلي الصورة تتمدد وتاخد المساحة كلها
                child: Image.asset(
                  page.imageUrl,
                  width: double.infinity, // 👈 تاخد العرض بالكامل
                  fit: BoxFit.cover, // أو استخدم BoxFit.fitWidth حسب ما تحب
                  errorBuilder: (ctx, err, _) => Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
