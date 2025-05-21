class KnowledgeModel {
  final int id;
  final String title;
  final String category;
  final String description;
  final bool isFavorite;

  KnowledgeModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    this.isFavorite = false,
  });

  factory KnowledgeModel.fromJson(Map<String, dynamic> json) {
    return KnowledgeModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      description: json['description'],
      isFavorite: json['isFavorite'],
    );
  }
}
