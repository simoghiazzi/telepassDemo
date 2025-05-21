import 'dart:math';
import 'package:ghiazzi/models/course_model.dart';

class CoursesRepository {
  Future<Map<String, dynamic>> getCourses(String token) async {
    //As already shown, as an example in sign_in_repository.dart, notification_repository.dart and courses_repository.dart,
    // we mock an actual API call that could be performed via the Dio package
    await Future.delayed(const Duration(seconds: 1));
    final random = Random();
    List<String> categories = [
      "servizi e prodotti",
      "compliance",
      "applicativi",
    ];

    List<String> titles = [
      "Progettazione e sviluppo di...",
      "Redazione di manuali di...",
      "Gestione dei sistemi di...",
    ];

    List<String> statuses = ["active", "completed", "pending"];

    List<String> images = [
      "assets/images/test/test1.png",
      "assets/images/test/test2.png",
      "assets/images/test/test3.png",
      "assets/images/test/test4.png",
      "assets/images/test/test5.png",
      "assets/images/test/test6.png",
    ];

    List<Map<String, dynamic>> courses = List.generate(18, (i) {
      int totalModules = random.nextInt(10) + 1;
      int completedModules = random.nextInt(totalModules + 1);
      String category = categories[random.nextInt(categories.length)];

      // Set dueDate for some courses: some in the past, some in the future, some null
      String? dueDate;
      if (i % 4 == 0) {
        // Past
        dueDate =
            DateTime.now()
                .subtract(Duration(days: random.nextInt(10) + 1))
                .toIso8601String();
      } else if (i % 4 == 1) {
        // In next 7 days
        dueDate =
            DateTime.now()
                .add(Duration(days: random.nextInt(7) + 1))
                .toIso8601String();
      } else if (i % 4 == 2) {
        // Far future
        dueDate =
            DateTime.now()
                .add(Duration(days: random.nextInt(100) + 10))
                .toIso8601String();
      } else {
        dueDate = null;
      }

      return {
        "id": i + 1,
        "title": titles[random.nextInt(titles.length)],
        "category": category,
        "modulesCount": totalModules,
        "points": random.nextInt(500) + 100,
        "dueDate": dueDate,
        "status": statuses[random.nextInt(statuses.length)],
        "imageUrl": images[random.nextInt(images.length)],
        "isFavorite": random.nextBool(),
        "completedModules": completedModules,
        "totalModules": totalModules,
        "isMandatory": random.nextBool(),
        "isOptional": random.nextBool(),
      };
    });
    return {"courses": courses};
  }

  Future<Map<String, dynamic>> getHighlightCourses(String token) async {
    //As already shown, as an example in sign_in_repository.dart, notification_repository.dart and courses_repository.dart,
    // we mock an actual API call that could be performed via the Dio package
    await Future.delayed(const Duration(seconds: 1));
    final random = Random();
    List<String> categories = [
      "servizi e prodotti",
      "compliance",
      "applicativi",
    ];

    List<String> titles = [
      "Progettazione e sviluppo di...",
      "Redazione di manuali di...",
      "Gestione dei sistemi di...",
    ];

    List<String> statuses = ["active", "completed", "pending"];

    List<String> images = [
      "assets/images/test/test1.png",
      "assets/images/test/test2.png",
      "assets/images/test/test3.png",
      "assets/images/test/test4.png",
      "assets/images/test/test5.png",
      "assets/images/test/test6.png",
    ];

    List<Map<String, dynamic>> courses = List.generate(5, (i) {
      int totalModules = random.nextInt(10) + 1;
      int completedModules = random.nextInt(totalModules + 1);
      String category = categories[random.nextInt(categories.length)];

      // Set dueDate for some courses: some in the past, some in the future, some null
      String? dueDate;
      if (i % 4 == 0) {
        // Past
        dueDate =
            DateTime.now()
                .subtract(Duration(days: random.nextInt(10) + 1))
                .toIso8601String();
      } else if (i % 4 == 1) {
        // In next 7 days
        dueDate =
            DateTime.now()
                .add(Duration(days: random.nextInt(7) + 1))
                .toIso8601String();
      } else if (i % 4 == 2) {
        // Far future
        dueDate =
            DateTime.now()
                .add(Duration(days: random.nextInt(100) + 10))
                .toIso8601String();
      } else {
        dueDate = null;
      }

      return {
        "id": i + 1,
        "title": titles[random.nextInt(titles.length)],
        "category": category,
        "modulesCount": totalModules,
        "points": random.nextInt(500) + 100,
        "dueDate": dueDate,
        "status": statuses[random.nextInt(statuses.length)],
        "imageUrl": images[random.nextInt(images.length)],
        "isFavorite": random.nextBool(),
        "completedModules": completedModules,
        "totalModules": totalModules,
        "isMandatory": random.nextBool(),
        "isOptional": random.nextBool(),
      };
    });
    return {"courses": courses};
  }

  Future<List<CourseModel>> toggleFavourite(
    int courseId,
    List<CourseModel> courses,
  ) async {
    //As already shown, as an example in sign_in_repository.dart, notification_repository.dart and courses_repository.dart,
    // we mock an actual API call that could be performed via the Dio package
    await Future.delayed(const Duration(milliseconds: 300));
    return courses.map((course) {
      if (course.id == courseId) {
        return CourseModel(
          id: course.id,
          title: course.title,
          category: course.category,
          modulesCount: course.modulesCount,
          points: course.points,
          dueDate: course.dueDate,
          status: course.status,
          imageUrl: course.imageUrl,
          isFavorite: !course.isFavorite,
          completedModules: course.completedModules,
          totalModules: course.totalModules,
          isMandatory: course.isMandatory,
          isOptional: course.isOptional,
        );
      }
      return course;
    }).toList();
  }
}
