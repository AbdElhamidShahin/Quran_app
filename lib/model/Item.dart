

class Item {
  final int chapter;
  final int verse;
  final String text;

  Item({
    required this.chapter,
    required this.verse,
    required this.text,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      chapter: json['chapter'] as int,
      verse: json['verse'] as int,
      text: json['text'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'chapter': chapter, 'verse': verse, 'text': text};
  }
}
