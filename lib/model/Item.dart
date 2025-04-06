class Item {
  final int page;
  final String imageUrl;
  final int surahNumber;
  final String surahNameAr;
  final String surahNameEn;
  final String transliteration;
  final int startVerse;
  final int endVerse;

  Item({
    required this.page,
    required this.imageUrl,
    required this.surahNumber,
    required this.surahNameAr,
    required this.surahNameEn,
    required this.transliteration,
    required this.startVerse,
    required this.endVerse,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    final start = json['start'];
    return Item(
      page: json['page'] as int,
      imageUrl: json['image']['url'] as String,
      surahNumber: start['surah_number'] as int,
      surahNameAr: start['name']['ar'] as String,
      surahNameEn: start['name']['en'] as String,
      transliteration: start['name']['transliteration'] as String,
      startVerse: start['verse'] as int,
      endVerse: json['end']['verse'] as int,
    );
  }

  int get versesCount => endVerse - startVerse + 1;
}