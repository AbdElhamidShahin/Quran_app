import 'package:flutter/material.dart';
import 'package:quran_app/model/azkarModel/ItemAzkatr.dart';
import '../../veiw_model/helper/thems/color.dart';
import '../wedgit/CustomContainer.dart';
import '../screens/My_QuranPage.dart';
import '../screens/azkarPage.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key, required this.height, this.azkarCategory,}) : super(key: key);
  final AzkarCategoryModel? azkarCategory;  // Make it nullable

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
                image: 'assets/icons/prayer.png',
                title: "الصلاه",
                color: favoritesColor,
                onpressed: () {},
              ),
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
                    MaterialPageRoute(
                      builder: (context) => AzkarPage(
                      ),
                    ),
                  );
                },
              ),
              CustomContainer(
                height1: height * .27,
                image: 'assets/icons/location.png',
                title: "القبله",
                color: qiblaColor,
                onpressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
