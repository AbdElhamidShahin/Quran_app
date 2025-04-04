import 'package:flutter/material.dart';
import 'package:quran_app/veiw/wedgit/buildContentScess.dart';
import 'package:quran_app/veiw/wedgit/buildEmptyWidget.dart';
import 'package:quran_app/veiw/wedgit/buildErrorWidget.dart';
import 'package:quran_app/veiw/wedgit/buildLoadingShimmer.dart';
import '../model/Item.dart';
import '../model/JsonScreen.dart';

class QuranDetailsScreen extends StatelessWidget {
  final String category;
  final String surahName; // Add surahName parameter

  const QuranDetailsScreen({
    super.key,
    required this.category,
    required this.surahName, // Require surahName
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFAEE), // تطبيق اللون كخلفية
      body: FutureBuilder<List<Item>>(
        future: fetchTravelFromJson(context, category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoadingShimmer();
          } else if (snapshot.hasError) {
            return buildErrorWidget(snapshot.error.toString());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return buildEmptyWidget();
          }

          return buildContentScess(snapshot.data!, surahName);
        },
      ),
    );
  }
}
