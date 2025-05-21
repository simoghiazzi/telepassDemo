import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghiazzi/models/reel_model.dart';
import '../repositories/reels_repository.dart';

abstract class ReelsState {}

class ReelsLoading extends ReelsState {}

class ReelsLoaded extends ReelsState {
  final List<ReelModel> reels;
  ReelsLoaded(this.reels);
}

class ReelsError extends ReelsState {
  final String message;
  ReelsError(this.message);
}

class ReelsViewModel extends Cubit<ReelsState> {
  final ReelsRepository repository;
  ReelsViewModel(this.repository) : super(ReelsLoading());

  Future<void> loadReels() async {
    emit(ReelsLoading());
    try {
      final reels = await repository.fetchReels();
      emit(ReelsLoaded(reels));
    } catch (e) {
      emit(ReelsError('Failed to load reels'));
    }
  }
}
