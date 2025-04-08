import 'package:flutter/material.dart';
import '../../model/item.dart';
import '../../model/JsonScreen.dart';
import '../../veiw_model/helper/thems/coloe.dart';
import '../wedgit/CustomQuranPage.dart';

class MyQuranPage extends StatelessWidget {
  const MyQuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text("myQuran", style: titleGreenStyle()),
        actions: [Icon(Icons.home, color: greenColor)],
      ),
      body: FutureBuilder<List<Item>>(
        future: fetchSuraDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: greenColor));
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error loading data', style: TextStyle(color: Colors.red)));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available', style: subtitleStyle()));
          }

          final suras = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: suras.length,
            itemBuilder: (BuildContext context, int index) {
              return CustomQuranPage(
                index: index,
                sura: suras[index],
              );
            },
          );
        },
      ),
    );
  }
}