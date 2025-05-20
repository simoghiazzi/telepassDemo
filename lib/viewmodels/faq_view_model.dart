import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghiazzi/models/faq_model.dart';
import 'package:ghiazzi/repositories/faq_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FaqState {}

class FaqInitial extends FaqState {}

class FaqLoading extends FaqState {}

class FaqError extends FaqState {
  final String error;
  FaqError(this.error);
}

class FaqSuccess extends FaqState {
  final List<FaqModel> faqs;
  FaqSuccess(this.faqs);
}

class FaqViewModel extends Cubit<FaqState> {
  final FaqRepository faqRepository;

  FaqViewModel(this.faqRepository) : super(FaqInitial());

  Future<void> getFaq() async {
    emit(FaqLoading());
    final prefs = await SharedPreferences.getInstance();
    try {
      String token = prefs.getString('userToken')!;
      final response = await faqRepository.getFaqs(token);
      final faqs =
          (response['faqs'] as List)
              .map((faq) => FaqModel.fromJson(faq))
              .toList();
      emit(FaqSuccess(faqs));
    } catch (e) {
      emit(FaqError(e.toString()));
    }
  }
}
