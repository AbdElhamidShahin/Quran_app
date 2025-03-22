import 'package:flutter/material.dart';

import '../../veiw_model/color/coloe.dart'; // تأكد من أن المسار صحيح

class MyQuranPage extends StatelessWidget {
  const MyQuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text("myQuran", style: titleGreenStyle()),
        actions: [Icon(Icons.home, color: greenColor)],
      ),
      backgroundColor: backgroundColor,

      body: Row(
        children: [ Divider(height: 5,color: Colors.red,thickness: 5,endIndent: 5,indent: 5,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text('الفاتحة', style: titleGreenStyle()),
              const SizedBox(height: 4),
              Text('مكية - 7 آيات', style: subtitleStyle()),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Al-Fatihah', style: titleGreenStyle()),
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
                '1',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
       ],

      ),
    );
  }
}
