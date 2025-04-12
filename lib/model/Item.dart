class Item {
  final String id; // إضافة معرّف فريد
  final int page;
  final String imageUrl;
  final int surahNumber;
  final String surahNameAr;
  final String surahNameEn;
  final String surahTransliteration;
  final int startVerse;
  final int endVerse;
  int versesCount;

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
  }) : id = '${surahNumber}_${page}'; // إنشاء ID من رقم السورة والصفحة

  factory Item.fromJson(Map<String, dynamic> json) {
    final start = json['start'];
    String imageUrl = json['image']['url'] as String;

    if (!imageUrl.startsWith('assets/') && !imageUrl.startsWith('http')) {
      imageUrl = 'assets/$imageUrl';
    }

    return Item(
      page: json['page'] as int,
      imageUrl: imageUrl,
      surahNumber: start['surah_number'] as int,
      surahNameAr: start['name']['ar'] as String,
      surahNameEn: start['name']['en'] as String,
      surahTransliteration: start['name']['transliteration'] as String,
      startVerse: start['verse'] as int,
      endVerse: json['end']['verse'] as int,
      versesCount: json['end']['verse'] - start['verse'] + 1,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'page': page,
    'image': {'url': imageUrl},
    'start': {
      'surah_number': surahNumber,
      'verse': startVerse,
      'name': {
        'ar': surahNameAr,
        'en': surahNameEn,
        'transliteration': surahTransliteration,
      },
    },
    'end': {'verse': endVerse},
    'versesCount': versesCount,
  };
}