class AzkarModel {
  final int id;
  final String text;
  final int count;
  final String audio;
  final String filename;

  AzkarModel({
    required this.id,
    required this.text,
    required this.count,
    required this.audio,
    required this.filename,
  });

  factory AzkarModel.fromJson(Map<String, dynamic> json) {
    return AzkarModel(
      id: json['id'],
      text: json['text'],
      count: json['count'],
      audio: json['audio'],
      filename: json['filename'],
    );
  }
}

class AzkarCategoryModel {
  final int id;
  final String category;
  final String audio;
  final String filename;
  final List<AzkarModel> array;

  AzkarCategoryModel({
    required this.id,
    required this.category,
    required this.audio,
    required this.filename,
    required this.array,
  });

  factory AzkarCategoryModel.fromJson(Map<String, dynamic> json) {
    var list = json['array'] as List;
    List<AzkarModel> azkarList =
        list.map((i) => AzkarModel.fromJson(i)).toList();

    return AzkarCategoryModel(
      id: json['id'],
      category: json['category'],
      audio: json['audio'],
      filename: json['filename'],
      array: azkarList,
    );
  }
}
