import 'package:flutter/material.dart';
import '../../model/item.dart';
import '../../veiw_model/helper/thems/color.dart';
Widget buildContentSuccess(
    BuildContext context,
    List<Item> pages,
    String surahName, {
      String? surahNameEn,
      String? transliteration,
    }) {
  return PageView.builder(
    controller: PageController(viewportFraction: 1.1),
    scrollDirection: Axis.horizontal,
    reverse: true,
    itemCount: pages.length,
    itemBuilder: (context, index) {
      final page = pages[index];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Image.asset(
          color: colorQuranPages(context),
          page.imageUrl,
          width: double.infinity,
          fit: BoxFit.fitWidth,
          errorBuilder: (ctx, err, _) => Container(
            color: Colors.grey[200],
            child: const Center(child: Icon(Icons.image_not_supported)),
          ),
        ),
      );
    },
  );
}
