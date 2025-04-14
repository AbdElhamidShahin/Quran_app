import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/veiw/QuranDetailsScreen.dart';
import 'package:quran_app/veiw/screens/HomePage.dart';
import 'package:quran_app/veiw/screens/My_QuranPage.dart';
import 'package:quran_app/veiw_model/helper/saveLastReadPage.dart';

import 'model/ItemProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadQuranData();
  runApp(    ChangeNotifierProvider(
    create: (context) => ItemProvider(),
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق القرآن',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: HomePage(),
      ),
    );
  }
}
