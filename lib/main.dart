import 'package:flutter/material.dart';
import 'package:quran_app/veiw/screens/HomePage.dart';

void main() {
  runApp(const MyApp());
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
        textDirection: TextDirection.rtl, // تحديد الاتجاه من اليمين لليسار
        child: HomePage(),
      ),
    );
  }
}
