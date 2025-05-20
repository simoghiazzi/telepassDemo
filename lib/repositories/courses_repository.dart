import 'dart:math';

class CoursesRepository {
  Future<Map<String, dynamic>> getCourses(String token) async {
    await Future.delayed(const Duration(seconds: 1));
    final random = Random();
    List<String> categories = [
      "servizi e prodotti",
      "compliance",
      "applicativi",
    ];
    List<String> statuses = ["active", "completed", "pending"];
    List<String> images = [
      "https://picsum.photos/200/300?random=1",
      "https://picsum.photos/200/300?random=2",
      "https://picsum.photos/200/300?random=3",
      "https://picsum.photos/200/300?random=4",
      "https://picsum.photos/200/300?random=5",
      "https://picsum.photos/200/300?random=6",
    ];
    List<Map<String, dynamic>> courses = List.generate(18, (i) {
      int totalModules = random.nextInt(10) + 1;
      int completedModules = random.nextInt(totalModules + 1);
      return {
        "id": i + 1,
        "title": "Course ${i + 1}",
        "category": categories[random.nextInt(categories.length)],
        "modulesCount": totalModules,
        "points": random.nextInt(500) + 100,
        "dueDate": null,
        "status": statuses[random.nextInt(statuses.length)],
        "imageUrl": images[random.nextInt(images.length)],
        "isFavorite": random.nextBool(),
        "completedModules": completedModules,
        "totalModules": totalModules,
      };
    });
    return {"courses": courses};
  }
}
