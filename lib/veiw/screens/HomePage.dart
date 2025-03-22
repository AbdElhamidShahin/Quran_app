import 'package:flutter/material.dart';
import 'package:quran_app/veiw/wedgit/Dashboard.dart' show Dashboard;
import 'package:quran_app/veiw/wedgit/LastReadWidget.dart' show LastReadWidget;

import '../../veiw_model/color/coloe.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        leading: Icon(Icons.menu, color: greenColor),
        title: Text("myQuran", style: titleGreenStyle()),
        actions: [
          CircleAvatar(
            backgroundColor: blueColor,
            backgroundImage: const AssetImage("assets/icons/moon.png"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: height * .01),
                child: Center(
                  child: Image(
                    image: const AssetImage('assets/icons/logo.png'),
                    width: width * .2,
                  ),
                ),
              ),
              LastReadWidget(height: height, width: width),
              Dashboard(height: height),
            ],
          ),
        ),
      ),
    );
  }
}

