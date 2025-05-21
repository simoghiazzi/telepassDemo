import 'package:ghiazzi/models/knowledge_model.dart';

class KnowledgeRepository {
  Future<Map<String, dynamic>> getHighlightKnowledge(String token) async {
    //As already shown, as an example in sign_in_repository.dart, notification_repository.dart and courses_repository.dart,
    // we mock an actual API call that could be performed via the Dio package
    await Future.delayed(const Duration(seconds: 2));
    List<String> categories = ["servizi ", "la nostra rete"];

    List<String> titles = [
      "Cambio IBAN",
      "Cambio targa",
      "Car sharing",
      "Mobilità sostenibile",
      "Trasporti e logistica",
    ];

    List<String> descriptions = [
      "Ho l'offerta Telepass Base e devo cambiare banca, cosa devo fare?",
      "Come posso modificare le targa associate al mio...",
      "Guida alla pianificazione e gestione delle reti di car...",
      "Strategie e pratiche per la città",
      "Ottimizzazione delle operazioni urbane",
    ];

    List<Map<String, dynamic>> knowledge = List.generate(5, (i) {
      String category = categories[i < 2 ? 0 : 1];

      return {
        "id": i + 1,
        "title": titles[i],
        "category": category,
        "description": descriptions[i],
        "isFavorite": false,
      };
    });
    return {"knowledge": knowledge};
  }

  Future<List<KnowledgeModel>> toggleFavourite(
    int knowledgeId,
    List<KnowledgeModel> knowledge,
  ) async {
    //As already shown, as an example in sign_in_repository.dart, notification_repository.dart and courses_repository.dart,
    // we mock an actual API call that could be performed via the Dio package
    await Future.delayed(const Duration(milliseconds: 300));
    return knowledge.map((knowledge) {
      if (knowledge.id == knowledgeId) {
        return KnowledgeModel(
          id: knowledge.id,
          title: knowledge.title,
          category: knowledge.category,
          description: knowledge.description,
          isFavorite: !knowledge.isFavorite,
        );
      }
      return knowledge;
    }).toList();
  }
}
