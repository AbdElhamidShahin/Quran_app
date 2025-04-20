import 'package:flutter/material.dart';
import '../../model/azkarModel/ItemAzkatr.dart';
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
      body: FutureBuilder<List<AzkarCategoryModel>>(
        future: fetchAzkarCategoryFromJson(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: accentColor));
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

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return CustomAzkarPage(azkarCategory: categories[index]);
            },
          );
        },
      ),
    );
  }
}
