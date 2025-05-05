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
  final int juz;            // ← هذا


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
    required this.juz,

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
      juz: json['juz'] as int,          // ← لازم تجيبه من الـ API

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
int calculateJuz(int page) {
// يمكن تعديل هذا ليشمل أكثر من تقسيم
if (page >= 1 && page <= 20) {
return 1;
} else if (page >= 21 && page <= 40) {
return 2;
} else if (page >= 41 && page <= 60) {
return 3;
} else if (page >= 61 && page <= 80) {
return 4;
} else if (page >= 81 && page <= 100) {
return 5;
} else if (page >= 101 && page <= 120) {
return 6;
} else if (page >= 121 && page <= 140) {
return 7;
} else if (page >= 141 && page <= 160) {
return 8;
} else if (page >= 161 && page <= 180) {
return 9;
} else if (page >= 181 && page <= 200) {
return 10;
}
// يمكنك إضافة باقي الأجزاء حسب الحاجة.
return 0; // في حالة عدم وجود تطابق.
}