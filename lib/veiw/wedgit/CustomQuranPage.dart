import 'package:flutter/material.dart';
import '../../model/item.dart';
import '../../veiw_model/helper/surahAyahCounts.dart';
import '../../veiw_model/helper/thems/coloe.dart';
import '../QuranDetailsScreen.dart';

class CustomQuranPage extends StatelessWidget {
  final int index;
  final Item sura;

  const CustomQuranPage({
    super.key,
    required this.index,
    required this.sura,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuranDetailsScreen(
              surahNumber: sura.surahNumber,
              surahName: sura.surahNameAr,
              surahNameEn: sura.surahNameEn,
              transliteration: sura.surahTransliteration,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            // رقم السورة
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: greenColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                sura.surahNumber.toString(),
                style: TextStyle(
                  color: greenColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // تفاصيل السورة
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sura.surahNameAr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'عدد الآيات: ${SurahAyahCounts[sura.surahNumber] ?? 'غير معروف'}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // الاسم الإنجليزي والترجمة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    sura.surahTransliteration,
                    style: titleGreenStyle(),
                  ),
                  Text(
                    sura.surahNameEn,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}