import 'package:bookmark/bookmark.dart';
import 'package:models/models.dart';

class BookmarkRepository {
  BookmarkRepository({required IBookmarkDatasource bookmarkDatasource})
      : _bookmarkDatasource = bookmarkDatasource;

  final IBookmarkDatasource _bookmarkDatasource;

  Future<List<Post>> getBookmarks({
    int pageNumber = 1,
    int pageSize = 10,
    String? searchValue,
  }) =>
      _bookmarkDatasource.getBookmarks(
        pageNumber: pageNumber,
        pageSize: pageSize,
        searchValue: searchValue,
      );

  Future<void> addBookmark(int postId) =>
      _bookmarkDatasource.addBookmark(postId);

  Future<void> deleteBookmake(int postId) =>
      _bookmarkDatasource.deleteBookmark(postId);
}
