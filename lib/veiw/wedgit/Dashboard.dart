import 'package:flutter/material.dart';
import 'package:quran_app/veiw/wedgit/CustomContainer.dart';

import '../../veiw_model/color/coloe.dart' show blueColor, greenColor, purpleColor, redColor;

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
                color: greenColor,
                onpressed: () {},
              ),
              CustomContainer(
                height1: height * .20,
                image: 'assets/icons/bookmark.png',
                title: "المفضله",
                color: purpleColor,
                onpressed: () {},
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
                color: redColor,
              ),
              CustomContainer(
                height1: height * .27,
                image: 'assets/icons/location.png',
                title: "القبله",
                color: blueColor,
                onpressed: () {},
              ),

              //CustomContainer(height1: height*.28, width1: width*.4)
            ],
          ),
        ),
      ],
    );
  }
}
