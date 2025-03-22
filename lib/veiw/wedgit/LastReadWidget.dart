import 'package:flutter/material.dart';

import '../../veiw_model/color/coloe.dart';
import 'GotoWidget.dart';

class LastReadWidget extends StatelessWidget {
  const LastReadWidget({Key? key, required this.height, required this.width})
    : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Fluttertoast.showToast(msg: "This feature will be available in next release"),
      onTap: () {},
      child: Container(
        height: height * .15,
        width: width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(1.5, 3), // changes position of shadow
            ),
          ],
          image: DecorationImage(
            image: AssetImage('assets/icons/dashboard.png'),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                secondaryColor.withOpacity(0.7),

                primaryColor.withOpacity(0.7),
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
                    title: Text("آخر قراءة", style: titleStyle()),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('الرحمن', style: titleStyle()),
                        Text('الآية رقم: 1', style: miniStyle()),

                        GotoWidget(),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
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
