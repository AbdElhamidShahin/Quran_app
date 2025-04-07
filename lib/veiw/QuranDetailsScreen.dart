// veiw/QuranDetailsScreen.dart
import 'package:flutter/material.dart';
import '../model/item.dart';
import '../model/JsonScreen.dart';
import 'wedgit/buildLoadingShimmer.dart';
import 'wedgit/buildErrorWidget.dart';
import 'wedgit/buildEmptyWidget.dart';
import 'wedgit/buildContentScess.dart';

class QuranDetailsScreen extends StatelessWidget {
  final int startPage;
  final String surahName;
  final String? surahNameEn;
  final String? transliteration;

  const QuranDetailsScreen({
    super.key,
    required this.startPage,
    required this.surahName,
    this.surahNameEn,
    this.transliteration,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(surahName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            if (surahNameEn != null || transliteration != null)
              Text(
                '${surahNameEn ?? ''} ${transliteration != null ? '($transliteration)' : ''}',
                style: const TextStyle(fontSize: 14),
              ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFEFAEE),
      ),
      body: FutureBuilder<List<Item>>(
        future: fetchQuranPages(startPage),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoadingShimmer();
          }
          if (snapshot.hasError) {
            return buildErrorWidget(snapshot.error.toString());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return buildEmptyWidget();
          }

          return buildContentSuccess(  context, // أضف context هنا

            snapshot.data!,
            surahName,
            surahNameEn: surahNameEn,
            transliteration: transliteration,
          );
        },
      ),
    );
  }
}