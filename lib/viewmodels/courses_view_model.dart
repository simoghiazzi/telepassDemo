import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghiazzi/models/course_model.dart';
import 'package:ghiazzi/repositories/courses_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CoursesState {}

class CoursesInitial extends CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesError extends CoursesState {
  final String error;
  CoursesError(this.error);
}

class CoursesSuccess extends CoursesState {
  final List<CourseModel> courses;
  CoursesSuccess(this.courses);
}

class CoursesViewModel extends Cubit<CoursesState> {
  final CoursesRepository coursesRepository;

  CoursesViewModel(this.coursesRepository) : super(CoursesInitial());

  Future<void> getCourses() async {
    emit(CoursesLoading());
    final prefs = await SharedPreferences.getInstance();
    try {
      String token = prefs.getString('userToken') ?? '';
      final response = await coursesRepository.getCourses(token);
      final courses = (response['courses'] as List)
          .map((course) => CourseModel.fromJson(course))
          .toList();
      emit(CoursesSuccess(courses));
    } catch (e) {
      emit(CoursesError(e.toString()));
    }
  }
}
