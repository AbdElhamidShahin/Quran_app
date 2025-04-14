import 'package:flutter/material.dart';
import '../../model/azkarModel/ItemAzkatr.dart';
import '../../veiw_model/helper/thems/TextStyle.dart';
import '../../veiw_model/helper/thems/color.dart';
import '../screens/AzkarDetailsPage.dart';

class CustomAzkarPage extends StatelessWidget {
  const CustomAzkarPage({super.key, this.azkarCategory});

  final AzkarCategoryModel? azkarCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AzkarDetailsPage(azkar: azkarCategory!),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: surfaceColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      azkarCategory?.category ?? '',
                      style: sajdaMarkerStyle(),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_back_ios, color: primaryDark),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
