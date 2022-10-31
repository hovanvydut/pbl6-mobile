part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object?> get props => [];
}

class GetBookmarks extends BookmarkEvent {}

class SearchButtonPressed extends BookmarkEvent{}

class AddBookmark extends BookmarkEvent {
  const AddBookmark(this.post);
  final Post post;

  @override
  List<Object?> get props => [post];
}

class DeleteBookmark extends BookmarkEvent {
  const DeleteBookmark(this.post);
  final Post post;

  @override
  List<Object?> get props => [post];
}

class SearchBookmark extends BookmarkEvent {
  const SearchBookmark(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}

class ScrollMoreBookmarks extends BookmarkEvent {}
