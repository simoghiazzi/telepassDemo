import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/slides_repository.dart';

abstract class SlidesState {}

class SlidesLoading extends SlidesState {}

class SlidesLoaded extends SlidesState {
  final List<String> slides;
  SlidesLoaded(this.slides);
}

class SlidesError extends SlidesState {}

class SlidesViewModel extends Cubit<SlidesState> {
  final SlidesRepository repository;
  SlidesViewModel(this.repository) : super(SlidesLoading());

  void loadSlides() {
    try {
      final slides = repository.getSlides();
      emit(SlidesLoaded(slides));
    } catch (_) {
      emit(SlidesError());
    }
  }
}
