import 'package:models/models.dart';
import 'package:review/review.dart';

class ReviewRepository {
  ReviewRepository({required IReviewDatasource reviewDatasource})
      : _reviewDatasource = reviewDatasource;

  final IReviewDatasource _reviewDatasource;

  Future<List<Review>> getReviewsByPostId(
    int postId, {
    int pageNumber = 1,
    int pageSize = 5,
    String? searchValue,
  }) =>
      _reviewDatasource.getReviewsByPostId(
        postId,
        pageNumber: pageNumber,
        pageSize: pageSize,
        searchValue: searchValue,
      );

  Future<void> createReview({
    required int postId,
    required String content,
    required int rating,
    required List<Media> medias,
  }) =>
      _reviewDatasource.createReview(
        postId: postId,
        content: content,
        rating: rating,
        medias: medias,
      );
}
