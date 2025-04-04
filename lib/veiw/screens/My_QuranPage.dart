import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/suraMap.dart';
import '../../veiw_model/color/coloe.dart';

import '../wedgit/CustomQuranPage.dart';

class MyQuranPage extends StatelessWidget {
  const MyQuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    final suras = suraMap.values.toList();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text("myQuran", style: titleGreenStyle()),
        actions: [Icon(Icons.home, color: greenColor)],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: suras.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomQuranPage(index: index);
        },
      ),
    );
  }
}
