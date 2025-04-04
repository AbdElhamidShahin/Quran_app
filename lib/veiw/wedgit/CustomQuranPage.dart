import 'package:flutter/material.dart';

import '../../model/suraMap.dart';
import '../../veiw_model/color/coloe.dart';
import '../QuranDetailsScreen.dart';

class CustomQuranPage extends StatelessWidget {
  final int index;
  const CustomQuranPage({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    final suras = suraMap.values.toList();
    final sura = suras[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuranDetailsScreen(category: '${index + 1}', surahName: sura["suraNameArabic"],),
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
                Text(sura["suraNameArabic"] ?? "", style: titleGreenStyle()),
                const SizedBox(height: 4),
                Text(
                  "${sura["suraVersesNumber"]} آيات",
                  style: subtitleStyle(),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                sura["suraNameEnglish"] ?? "",
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
                  sura["index"] ?? "",
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
