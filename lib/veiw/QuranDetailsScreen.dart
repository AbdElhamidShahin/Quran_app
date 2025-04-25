import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/item.dart';
import '../model/JsonScreen.dart';
import '../veiw_model/helper/thems/TextStyle.dart';
import '../veiw_model/helper/thems/color.dart';
import 'wedgit/buildLoadingShimmer.dart';
import 'wedgit/buildErrorWidget.dart';
import 'wedgit/buildEmptyWidget.dart';
import 'wedgit/buildContentScess.dart';

class QuranDetailsScreen extends StatefulWidget {
  final int surahNumber;
  final int pageNumber;
  final String surahName;
  final String? surahNameEn;
  final String? transliteration;

  const QuranDetailsScreen({
    super.key,
    required this.pageNumber,
    required this.surahNumber,
    required this.surahName,
    this.surahNameEn,
    this.transliteration,
  });

  @override
  State<QuranDetailsScreen> createState() => _QuranDetailsScreenState();
}

class _QuranDetailsScreenState extends State<QuranDetailsScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.pageNumber);
    _saveLastReadPage(widget.pageNumber);
  }

  // دالة لحفظ الصفحة الأخيرة في SharedPreferences
  Future<void> _saveLastReadPage(int pageNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_read_page', pageNumber);
    await prefs.setInt('last_read_surah', widget.surahNumber);
    await prefs.setString('last_read_surah_name', widget.surahName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor(context),
        title: Column(
          children: [
            Text("سوره ${widget.surahName}", style: appBarTitleStyle()),
          ],
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
            child: Text("${widget.pageNumber}", style: appBodyStyle()),
          ),
        ),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: 604, // عدد الصفحات
        onPageChanged: (index) {
          _saveLastReadPage(index); // حفظ الصفحة عند التغيير
        },
        itemBuilder: (context, index) {
          return FutureBuilder<List<Item>>(
            future: fetchQuranPagesBySurah(widget.surahNumber),
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
                widget.surahName,
                surahNameEn: widget.surahNameEn,
                transliteration: widget.transliteration,
              );
            },
          );
        },
      ),
    );
  }
}
