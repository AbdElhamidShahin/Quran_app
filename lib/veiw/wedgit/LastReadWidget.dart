import 'package:flutter/material.dart';
import '../../veiw_model/helper/saveLastReadPage.dart';
import '../../veiw_model/helper/thems/TextStyle.dart';
import '../../veiw_model/helper/thems/color.dart';
import 'GotoWidget.dart';
import '../QuranDetailsScreen.dart';
import 'package:quran_app/model/item.dart';

class LastReadWidget extends StatelessWidget {
  const LastReadWidget({
    Key? key,
    required this.height,
    required this.width,
    this.sura,
  }) : super(key: key);

  final Item? sura;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        final lastRead = await getLastReadPage();

        if (lastRead != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuranDetailsScreen(
                pageNumber: lastRead['page'],
                surahNumber: lastRead['surah'],
                surahName: lastRead['surahName'],
                // لو حابب تبعت En Name أو Transliteration ضيفهم كمان لو كنت حافظهم
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("لا يوجد قراءة محفوظة")),
          );
        }
      },
      child: Container(
        height: height * .18,
        width: width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(1.5, 3),
            ),
          ],
          image: const DecorationImage(
            image: AssetImage('assets/icons/dashboard.png'),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                favoritesColor.withOpacity(0.7),
                lastReadingColor.withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .03,
                  vertical: height * .02,
                ),
                child: SizedBox(
                  width: width * .4,
                  child: ListTile(
                    title: Text("آخر قراءة", style: sectionHeaderStyle()),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'اضغط للمتابعة من حيث توقفت',
                          style: tafsirTextStyle(),
                        ),
                        const SizedBox(height: 4),
                        const GotoWidget(),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(right: width * .04),
                child: SizedBox(
                  height: height * .15,
                  width: width * .3,
                  child: Image.asset('assets/icons/lamp.png', fit: BoxFit.fill),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
