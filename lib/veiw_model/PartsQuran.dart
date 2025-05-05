//
// import 'package:flutter/material.dart';
//
// import '../model/item.dart';
//
// class QuranPageList extends StatelessWidget {
//   final List<Item> items;
//
//   const QuranPageList({super.key, required this.items});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("سور القرآن"),
//       ),
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           final item = items[index];
//           return ListTile(
//             title: Text("سورة ${item.surahNameAr} - الصفحة ${item.page}"),
//             subtitle: Text("الجزء: ${item.juz}"),
//             trailing: Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               // عند الضغط على العنصر يمكن إضافة صفحة جديدة لعرض التفاصيل
//               // مثل فتح صفحة التفاصيل الخاصة بالسورة
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class JuzListPage extends StatelessWidget {
//   final Map<int, List<Item>> allJuzItems;
//
//   const JuzListPage({super.key, required this.allJuzItems});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("أجزاء القرآن"),
//       ),
//       body: ListView.builder(
//         itemCount: 30,
//         itemBuilder: (context, index) {
//           final juzNumber = index + 1;
//           final items = allJuzItems[juzNumber] ?? [];
//
//           return ListTile(
//             title: Text("الجزء $juzNumber"),
//             trailing: Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               if (items.isNotEmpty) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => QuranPageList(
//                       items: items,
//                     ),
//                   ),
//                 );
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// // دالة لتقسيم العناصر حسب الجزء
// Map<int, List<Item>> splitItemsByJuz(List<Item> allItems) {
//   Map<int, List<Item>> map = {};
//   for (var item in allItems) {
//     map.putIfAbsent(item.juz, () => []).add(item);
//   }
//   return map;
// }