class CourseModel {
  final String id;
  final String title;
  final String category;
  final int modulesCount;
  final int points;
  final String? dueDate;
  final String status;
  final String imageUrl;
  final bool isFavorite;
  final int? completedModules;
  final int? totalModules;

  CourseModel({
    required this.id,
    required this.title,
    required this.category,
    required this.modulesCount,
    required this.points,
    this.dueDate,
    required this.status,
    required this.imageUrl,
    this.isFavorite = false,
    this.completedModules,
    this.totalModules,
  });

  double? get progress {
    if (completedModules != null && totalModules != null && totalModules! > 0) {
      return completedModules! / totalModules!;
    }
    return null;
  }

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      modulesCount: json['modulesCount'],
      points: json['points'],
      dueDate: json['dueDate'],
      status: json['status'],
      imageUrl: json['imageUrl'],
      isFavorite: json['isFavorite'],
      completedModules: json['completedModules'],
      totalModules: json['totalModules'],
    );
  }
}
