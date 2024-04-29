class TranslationModel {
  final String id;
  final String text;

  TranslationModel({required this.id, required this.text});

  factory TranslationModel.fromJson(Map<String, dynamic> json) =>
      TranslationModel(id: json['id'], text: json['text']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
      };
}
