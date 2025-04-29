import 'package:flutter/material.dart';
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

            // عرض النتائج
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
                  final azkar = results[index];
                  final categoryName = azkar['category'] ?? 'no name';

                  return GestureDetector(
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
                                categoryName,
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
    final List<AzkarCategoryModel> allAzkar = await fetchAzkarCategoryFromJson();

    final List<Map<String, dynamic>> results = allAzkar
        .where(
          (azkar) =>
          azkar.category.toLowerCase().contains(query.toLowerCase()),
    )
        .map((azkar) => azkar.toJson())
        .toList();

    return results;
  }
}