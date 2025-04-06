// veiw/wedgit/CustomQuranPage.dart
import 'package:flutter/material.dart';
import '../../model/item.dart';
import '../../veiw_model/color/coloe.dart';
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
              startPage: sura.page,
              surahName: sura.surahNameAr,
              surahNameEn: sura.surahNameEn,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(width: 5, height: 50, color: Colors.red),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sura.surahNameAr, style: titleGreenStyle()),
                const SizedBox(height: 4),
                Text(
                  "${sura.versesCount} آيات",
                  style: subtitleStyle(),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                sura.surahNameEn,
                style: titleGreenStyle(),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/icons/images (1) (1) (1).png',
                  width: 50,
                  height: 50,
                  color: greenColor,
                ),
                Text(
                  sura.surahNumber.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}