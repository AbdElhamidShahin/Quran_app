import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/veiw/screens/HomePage.dart';
import 'package:quran_app/veiw_model/helper/saveLastReadPage.dart';

import 'model/ItemProvider.dart';
import 'model/api/apiServise.dart';
import 'model/bloc/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadQuranData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemProvider()),
        BlocProvider<PrayerBloc>(
          create: (_) => PrayerBloc(PrayerService(), Connectivity()),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
