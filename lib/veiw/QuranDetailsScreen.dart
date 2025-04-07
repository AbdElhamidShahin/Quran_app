import 'package:flutter/material.dart';
import '../model/item.dart';
import '../model/JsonScreen.dart';
import '../veiw_model/color/coloe.dart';
import 'wedgit/buildLoadingShimmer.dart';
import 'wedgit/buildErrorWidget.dart';
import 'wedgit/buildEmptyWidget.dart';
import 'wedgit/buildContentScess.dart';

class QuranDetailsScreen extends StatelessWidget {
  final int surahNumber; // ✅ بدل startPage
  final String surahName;
  final String? surahNameEn;
  final String? transliteration;

  const QuranDetailsScreen({
    super.key,
    required this.surahNumber, // ✅ تعديل هنا
    required this.surahName,
    this.surahNameEn,
    this.transliteration,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Column(
          children: [Text("سوره ${surahName}", style: titleGreenStyle())],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);


            },
            icon: Icon(Icons.arrow_forward_outlined),
          ),
        ],
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text("${surahNumber}",style: subtitleStyle(),),
          ),
        ),

        centerTitle: true,
      ),
      body: FutureBuilder<List<Item>>(
        future: fetchQuranPagesBySurah(surahNumber),
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

          return buildContentSuccess(
            context,
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
