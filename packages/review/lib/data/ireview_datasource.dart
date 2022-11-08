import 'package:models/models.dart';

abstract class IReviewDatasource {
  Future<List<Review>> getReviewsByPostId(
    int postId, {
    int pageNumber = 1,
    int pageSize = 5,
    String? searchValue,
  });

  Future<void> createReview({
    required int postId,
    required String content,
    required int rating,
    required List<Media> medias,
  });
}
