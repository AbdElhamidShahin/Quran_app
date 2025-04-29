import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../veiw/screens/AzkarDetailsPage.dart' show AzkarDetailsPage;
import 'ItemAzkatr.dart';
import 'azkarJsonScreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> results = [];
  String query = "";

  void search(String query) async {
    var resultsList = await ExerciseService.searchExercises(query);
    setState(() {
      results = resultsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                onChanged: (text) {
                  setState(() {
                    query = text;
                  });
                  search(query);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Discover your place',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .90,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                ),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final item = results[index];

                  return GestureDetector(
                    // onTap: () {
                    //   final azkar = AzkarModel.fromJson(item);
                    //
                    //   if (azkar != null) {
                    //     Navigator.of(context).push(
                    //       PageRouteBuilder(
                    //         pageBuilder:
                    //             (context, animation, secondaryAnimation) =>
                    //                 AzkarDetailsPage(azkar: azkar),
                    //         transitionsBuilder: (
                    //           context,
                    //           animation,
                    //           secondaryAnimation,
                    //           child,
                    //         ) {
                    //           var slideAnimation = Tween<Offset>(
                    //             begin: const Offset(
                    //               1.0,
                    //               0.5,
                    //             ), // يبدأ من الزاوية
                    //             end: Offset.zero, // ينتهي في المنتصف
                    //           ).animate(
                    //             CurvedAnimation(
                    //               parent: animation,
                    //               curve: Curves.easeInOutExpo,
                    //             ),
                    //           );
                    //
                    //           var rotationAnimation = Tween<double>(
                    //             begin: -0.2,
                    //             end: 0.0,
                    //           ).animate(
                    //             CurvedAnimation(
                    //               parent: animation,
                    //               curve: Curves.easeOutBack,
                    //             ),
                    //           );
                    //
                    //           var scaleAnimation = Tween<double>(
                    //             begin: 0.8,
                    //             end: 1.0,
                    //           ).animate(
                    //             CurvedAnimation(
                    //               parent: animation,
                    //               curve: Curves.fastOutSlowIn,
                    //             ),
                    //           );
                    //           return Stack(
                    //             children: [
                    //               Positioned.fill(
                    //                 child: AnimatedBuilder(
                    //                   animation: animation,
                    //                   builder: (context, _) {
                    //                     return Container(
                    //                       decoration: BoxDecoration(
                    //                         gradient: RadialGradient(
                    //                           colors: [
                    //                             Colors.lightBlueAccent
                    //                                 .withOpacity(
                    //                                   animation.value,
                    //                                 ), // لون أزرق فاتح
                    //                             Colors.white.withOpacity(
                    //                               1 - animation.value,
                    //                             ), // خلفية بيضاء
                    //                           ],
                    //                           radius: 2.5,
                    //                           center: Alignment(
                    //                             animation.value - 0.1,
                    //                             animation.value,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     );
                    //                   },
                    //                 ),
                    //               ),
                    //               // تأثير Lottie مع الحركة
                    //               SlideTransition(
                    //                 position: slideAnimation,
                    //                 child: RotationTransition(
                    //                   turns: rotationAnimation,
                    //                   child: ScaleTransition(
                    //                     scale: scaleAnimation,
                    //                     child: child,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           );
                    //         },
                    //         transitionDuration: const Duration(
                    //           milliseconds: 1800,
                    //         ),
                    //       ),
                    //     );
                    //   }
                    // },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                item['text'] ??
                                    'No Name', // Default text if 'name' is null
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseService {
  static Future<List<Map<String, dynamic>>> searchExercises(
    String query,
  ) async {
    final List<AzkarCategoryModel> allAzkar =
        await fetchAzkarCategoryFromJson();

    final List<Map<String, dynamic>> results =
        allAzkar
            .where(
              (azkar) =>
                  azkar.category != null &&
                  azkar.category!.toLowerCase().contains(query.toLowerCase()),
            )
            .map((azkar) => azkar.toJson())
            .toList();

    return results;
  }
}
