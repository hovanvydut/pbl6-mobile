part of 'bookmark_bloc.dart';

enum FilterMode { all, searching }

class BookmarkState extends Equatable {
  const BookmarkState({
    this.bookmarks = const [],
    this.searchedBookmarks = const [],
    this.filterMode = FilterMode.all,
    this.isSearching = false,
    this.getBookmarksStatus = LoadingStatus.initial,
    this.getBookmarkMoreStatus = LoadingStatus.initial,
    this.deleteBookmarkStatus = LoadingStatus.initial,
    this.addBookmarkStatus = LoadingStatus.initial,
    this.currentSearchValue = '',
    this.currentPageAll = 1,
    this.currentPageSearching = 1,
  });
  final List<Post> bookmarks;
  final List<Post> searchedBookmarks;
  final FilterMode filterMode;
  final bool isSearching;
  final LoadingStatus getBookmarksStatus;
  final LoadingStatus getBookmarkMoreStatus;
  final LoadingStatus deleteBookmarkStatus;
  final LoadingStatus addBookmarkStatus;
  final String currentSearchValue;
  final int currentPageAll;
  final int currentPageSearching;

  @override
  List<Object?> get props {
    return [
      bookmarks,
      searchedBookmarks,
      filterMode,
      isSearching,
      getBookmarksStatus,
      getBookmarkMoreStatus,
      deleteBookmarkStatus,
      addBookmarkStatus,
      currentSearchValue,
      currentPageAll,
      currentPageSearching,
    ];
  }

  BookmarkState copyWith({
    List<Post>? bookmarks,
    List<Post>? searchedBookmarks,
    FilterMode? filterMode,
    bool? isSearching,
    LoadingStatus? getBookmarksStatus,
    LoadingStatus? getBookmarkMoreStatus,
    LoadingStatus? deleteBookmarkStatus,
    LoadingStatus? addBookmarkStatus,
    String? currentSearchValue,
    int? currentPageAll,
    int? currentPageSearching,
  }) {
    return BookmarkState(
      bookmarks: bookmarks ?? this.bookmarks,
      searchedBookmarks: searchedBookmarks ?? this.searchedBookmarks,
      filterMode: filterMode ?? this.filterMode,
      isSearching: isSearching ?? this.isSearching,
      getBookmarksStatus: getBookmarksStatus ?? this.getBookmarksStatus,
      getBookmarkMoreStatus:
          getBookmarkMoreStatus ?? this.getBookmarkMoreStatus,
      deleteBookmarkStatus: deleteBookmarkStatus ?? this.deleteBookmarkStatus,
      addBookmarkStatus: addBookmarkStatus ?? this.addBookmarkStatus,
      currentSearchValue: currentSearchValue ?? this.currentSearchValue,
      currentPageAll: currentPageAll ?? this.currentPageAll,
      currentPageSearching: currentPageSearching ?? this.currentPageSearching,
    );
  }
}
