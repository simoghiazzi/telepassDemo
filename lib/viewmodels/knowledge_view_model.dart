import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghiazzi/models/knowledge_model.dart';
import 'package:ghiazzi/repositories/knowledge_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class KnowledgeState {}

class KnowledgeInitial extends KnowledgeState {}

class KnowledgeLoading extends KnowledgeState {}

class KnowledgeError extends KnowledgeState {
  final String error;
  KnowledgeError(this.error);
}

class KnowledgeSuccess extends KnowledgeState {
  final List<KnowledgeModel> knowledge;
  KnowledgeSuccess(this.knowledge);
}

class KnowledgeViewModel extends Cubit<KnowledgeState> {
  final KnowledgeRepository knowledgeRepository;

  KnowledgeViewModel(this.knowledgeRepository) : super(KnowledgeInitial());

  Future<void> getKnowledge() async {
    emit(KnowledgeLoading());
    final prefs = await SharedPreferences.getInstance();
    try {
      String token = prefs.getString('userToken') ?? '';
      final response = await knowledgeRepository.getHighlightKnowledge(token);
      final knowledge =
          (response['knowledge'] as List)
              .map((knowledge) => KnowledgeModel.fromJson(knowledge))
              .toList();
      emit(KnowledgeSuccess(knowledge));
    } catch (e) {
      emit(KnowledgeError(e.toString()));
    }
  }

  Future<void> toggleFavourite(int knowledgeId) async {
    if (state is KnowledgeSuccess) {
      final currentKnowledge = (state as KnowledgeSuccess).knowledge;
      // Simulate update via repository
      final updatedKnowledge = await knowledgeRepository.toggleFavourite(
        knowledgeId,
        currentKnowledge,
      );
      emit(KnowledgeSuccess(updatedKnowledge));
    }
  }
}
