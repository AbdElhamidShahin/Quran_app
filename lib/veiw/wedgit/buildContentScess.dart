import 'package:flutter/material.dart';
import '../../model/item.dart';

import 'package:flutter/material.dart';
import '../../model/item.dart';

Widget buildContentSuccess(
    BuildContext context, // أضفنا context هنا
    List<Item> pages,
    String surahName, {
      String? surahNameEn,
      String? transliteration,
    }) {
  return ListView.builder(
    padding: const EdgeInsets.all(16), // زيادة البادنج
    itemCount: pages.length,
    itemBuilder: (context, index) {
      final page = pages[index];
      return Card(
        elevation: 3, // إضافة ظل للبطاقة
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // رأس البطاقة
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'ص ${page.page}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surahName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'الآيات ${page.startVerse}-${page.endVerse}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // صورة الصفحة
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    page.imageUrl,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 300,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 300,
                        color: Colors.grey[200],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.broken_image, size: 60, color: Colors.grey),
                            SizedBox(height: 8),
                            Text('تعذر تحميل الصورة'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            // تذييل البطاقة
            if (index == 0) ...[
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'سورة $surahName',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (surahNameEn != null || transliteration != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          '${surahNameEn ?? ''} ${transliteration != null ? '($transliteration)' : ''}',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      );
    },
  );
}