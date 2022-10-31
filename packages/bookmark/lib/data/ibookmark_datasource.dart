import 'package:models/models.dart';

abstract class IBookmarkDatasource {
  Future<List<Post>> getBookmarks({
    int pageNumber = 1,
    int pageSize = 10,
    String? searchValue,
  });

  Future<void> addBookmark(int postId);

  Future<void> deleteBookmark(int postId);
}
