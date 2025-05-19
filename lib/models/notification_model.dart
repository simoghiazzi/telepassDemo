enum NotificationCategory {
  expiring, // Corso in scadenza
  achievement, // Badge in arrivo
  update, // Nuovo corso/documento
}

class NotificationModel {
  final String title;
  final String body;
  final String createdAt;
  final NotificationCategory category;

  NotificationModel({
    required this.title,
    required this.body,
    required this.createdAt,
    required this.category,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        title: json['title'] as String,
        body: json['body'] as String,
        createdAt: json['createdAt'] as String,
        category: NotificationCategory.values.firstWhere(
          (e) => e.name.toLowerCase() == json['category'].toLowerCase(),
          orElse: () => NotificationCategory.update,
        ),
      );
}
