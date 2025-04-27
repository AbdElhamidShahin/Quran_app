import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLastReadPage(int pageNumber) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('last_read_page', pageNumber);
}
Future<int?> getLastReadPage() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('last_read_page');
}