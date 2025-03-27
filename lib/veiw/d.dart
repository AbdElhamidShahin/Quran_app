import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../model/Item.dart';
import '../model/JsonScreen.dart';

class PushItemData extends StatelessWidget {
  final String category;

  const PushItemData({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سورة الفاتحة', style: TextStyle(fontSize: 24)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Item>>(
        future: fetchTravelFromJson(context, category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          /// 2) حالة الخطأ
          else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          }

          /// 3) حالة عدم وجود بيانات
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لم يتم العثور على آيات'));
          }

          /// 4) حالة النجاح (عرض البيانات)
          final items = snapshot.data!;

          // تكوين نص واحد يشمل جميع الآيات بجانب بعضها
          final allVerses = items.map((item) => "${item.text} ﴿${item.verse}﴾").join("  ");

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                allVerses,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  height: 1.6,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
