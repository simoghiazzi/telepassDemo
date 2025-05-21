import '../models/reel_model.dart';

class ReelsRepository {
  // Simulate API call
  Future<List<ReelModel>> fetchReels() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final images = [
      "assets/images/test/test1.png",
      "assets/images/test/test2.png",
      "assets/images/test/test3.png",
      "assets/images/test/test4.png",
      "assets/images/test/test5.png",
      "assets/images/test/test6.png",
    ];
    List<ReelModel> reels = List.generate(
      8,
      (i) => ReelModel(
        id: (i + 1).toString(),
        title: 'Reel ${i + 1}',
        imageUrl: images[i % images.length],
        highlighted: i < 5, // First 5 are active
      ),
    );
    return reels;
  }
}
