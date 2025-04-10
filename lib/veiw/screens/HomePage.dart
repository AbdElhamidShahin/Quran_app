import 'package:flutter/material.dart';
import 'package:quran_app/veiw/wedgit/Dashboard.dart' show Dashboard;
import 'package:quran_app/veiw/wedgit/LastReadWidget.dart' show LastReadWidget;

import '../../veiw_model/helper/thems/TextStyle.dart';
import '../../veiw_model/helper/thems/color.dart';

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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu, color: primaryColor, size: 28),
            ),
          ),
        ],
        title: Text("القرأن الكريم", style: appBarTitleStyle()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 12),

              Padding(
                padding: EdgeInsets.only(bottom: height * .01),
                child: Center(
                  child: Image(
                    image: const AssetImage('assets/icons/logo.png'),
                    width: width * .3,
                  ),
                ),
              ),
              SizedBox(height: 12),
              LastReadWidget(height: height, width: width),
              Dashboard(height: height),
            ],
          ),
        ),
      ),
    );
  }
}
