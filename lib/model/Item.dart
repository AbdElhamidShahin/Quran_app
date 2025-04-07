class Item {
  final int page;
  final String imageUrl;
  final int surahNumber;
  final String surahNameAr;
  final String surahNameEn;
  final String surahTransliteration;
  final int startVerse;
  final int endVerse;
  final int versesCount; // هذا الحقل يجب أن يحسب بشكل صحيح

  Item({
    required this.page,
    required this.imageUrl,
    required this.surahNumber,
    required this.surahNameAr,
    required this.surahNameEn,
    required this.surahTransliteration,
    required this.startVerse,
    required this.endVerse,
    required this.versesCount,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    final start = json['start'];
    final end = json['end'];

    // حساب عدد الآيات بشكل صحيح
    final verses = (end['verse'] as int) - (start['verse'] as int) + 1;

    return Item(
      page: json['page'] as int,
      imageUrl: json['image']['url'] as String,
      surahNumber: start['surah_number'] as int,
      surahNameAr: start['name']['ar'] as String,
      surahNameEn: start['name']['en'] as String,
      surahTransliteration: start['name']['transliteration'] as String,
      startVerse: start['verse'] as int,
      endVerse: end['verse'] as int,
      versesCount: verses, // هنا يتم تعيين عدد الآيات المحسوب
    );
  }
}