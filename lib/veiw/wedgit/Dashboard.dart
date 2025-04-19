import 'package:flutter/material.dart';
import 'package:quran_app/veiw/screens/azkarPage.dart';
import 'package:quran_app/veiw/wedgit/CustomContainer.dart';

import '../../veiw_model/helper/thems/color.dart';
import '../screens/My_QuranPage.dart';
import '../screens/salaScreen.dart';
import '../screens/sephaScreen.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key, required this.height}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          child: Column(
            children: [
              CustomContainer(
                height1: height * .27,
                image: 'assets/icons/quran.png',
                title: "القرأن الكريم",
                color: quranColor,
                onpressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyQuranPage()),
                  );
                },
              ),
              CustomContainer(
                height1: height * .20,
                image: 'assets/icons/bookmark.png',
                title: "مواقيت الصلاه ",
                color: favoritesColor,
                onpressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrayerTimesScreen()),
                );
                },
              ),
              //CustomContainer(height1: height*.28, width1: width*.4)
            ],
          ),
        ),
        Spacer(),
        SizedBox(
          child: Column(
            children: [
              CustomContainer(
                height1: height * .2,
                image: 'assets/icons/prayer.png',
                title: "أذكار الصباح والمساء",
                color: azkarColor,
                onpressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AzkarPage()),
                  );
                },
              ),
              CustomContainer(
                height1: height * .27,
                image: 'assets/icons/location.png',
                title: "المسبحه",
                color: qiblaColor,
                onpressed: () {     Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SephaScreen()),
                );},
              ),

              //CustomContainer(height1: height*.28, width1: width*.4)
            ],
          ),
        ),
      ],
    );
  }
}
