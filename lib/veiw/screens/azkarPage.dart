import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import '../../model/azkarModel/ItemAzkatr.dart';
import '../../model/azkarModel/SearchScreen.dart';
import '../../model/azkarModel/azkarJsonScreen.dart';
import '../../veiw_model/helper/thems/TextStyle.dart';
import '../../veiw_model/helper/thems/color.dart';
import '../wedgit/CustomAppBar.dart';
import '../wedgit/CustomAzkarPage.dart';

class AzkarPage extends StatelessWidget {
  const AzkarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ('الأذكار')),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: TextField(
              textDirection:
                  TextDirection.rtl, // تحديد اتجاه الكتابة من اليمين لليسار
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z0-9\u0600-\u06FF\s]'),
                ),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '     ابحث عن الاذكار',
                hintStyle: selectedAyahStyle(),
                prefixIcon: const Icon(Icons.search, color: primaryDark),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 40, // يمكنك تعديل الحجم حسب الحاجة
                ),
              ),
              textAlign: TextAlign.right, // جعل النص يبدأ من اليمين
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
            ),
          ),
          FutureBuilder<List<AzkarCategoryModel>>(
            future: fetchAzkarCategoryFromJson(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: accentColor),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'حدث خطأ أثناء تحميل البيانات',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text('لا توجد بيانات متاحة', style: appBodyStyle()),
                );
              }

              final categories = snapshot.data!;

              return Expanded(
                child: GridView.builder(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: const EdgeInsets.all(8),
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: .5,
                    mainAxisSpacing: 0.5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return CustomAzkarPage(azkarCategory: categories[index]);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
