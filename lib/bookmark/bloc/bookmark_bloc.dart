import 'dart:async';

import 'package:bookmark/bookmark.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc({
    required BookmarkRepository bookmarkRepository,
    required AuthenticationBloc authenticationBloc,
  })  : _bookmarkRepository = bookmarkRepository,
        _authenticationBloc = authenticationBloc,
        super(const BookmarkState()) {
    on<GetBookmarks>(_onGetBookmarks);
    on<SearchButtonPressed>(_onSearchButtonPressed);
    on<AddBookmark>(_onAddBookmark);
    on<DeleteBookmark>(_onDeleteBookmark);
    on<SearchBookmark>(_onSearchBookmark);
    on<ScrollMoreBookmarks>(_onScrollMoreBookmarks);
    _authenticationBloc.stream.listen((state) {
      if (state.user != null) {
        add(GetBookmarks());
      }
    });
  }

  final BookmarkRepository _bookmarkRepository;

  final AuthenticationBloc _authenticationBloc;

  Future<void> _onGetBookmarks(
    GetBookmarks event,
    Emitter<BookmarkState> emit,
  ) async {
    try {
      emit(state.copyWith(getBookmarksStatus: LoadingStatus.loading));
      final bookmarks = await _bookmarkRepository.getBookmarks();
      emit(
        state.copyWith(
          getBookmarksStatus: LoadingStatus.done,
          bookmarks: bookmarks,
          searchedBookmarks: bookmarks,
          currentPageAll: 2,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(getBookmarksStatus: LoadingStatus.error));
      rethrow;
    }
  }

  Future<void> _onAddBookmark(
    AddBookmark event,
    Emitter<BookmarkState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          addBookmarkStatus: LoadingStatus.loading,
        ),
      );
      await _bookmarkRepository.addBookmark(event.post.id);
      emit(
        state.copyWith(
          bookmarks: [...state.bookmarks, event.post],
          searchedBookmarks: [...state.bookmarks, event.post],
          addBookmarkStatus: LoadingStatus.done,
        ),
      );
    } catch (e) {
      addError(e);
      emit(
        state.copyWith(
          addBookmarkStatus: LoadingStatus.error,
        ),
      );
      rethrow;
    }
  }

  Future<void> _onDeleteBookmark(
    DeleteBookmark event,
    Emitter<BookmarkState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          deleteBookmarkStatus: LoadingStatus.loading,
        ),
      );
      await _bookmarkRepository.deleteBookmake(event.post.id);
      emit(
        state.copyWith(
          deleteBookmarkStatus: LoadingStatus.done,
          bookmarks: state.bookmarks
              .where((post) => post.id != event.post.id)
              .toList(),
          searchedBookmarks: state.bookmarks
              .where((post) => post.id != event.post.id)
              .toList(),
        ),
      );
    } catch (e) {
      addError(e);
      emit(
        state.copyWith(
          deleteBookmarkStatus: LoadingStatus.error,
        ),
      );
    }
  }

  Future<void> _onSearchBookmark(
    SearchBookmark event,
    Emitter<BookmarkState> emit,
  ) async {
    if (event.value.isNotEmpty) {
      try {
        emit(
          state.copyWith(
            getBookmarksStatus: LoadingStatus.loading,
            filterMode: FilterMode.searching,
          ),
        );
        final searchedBookmarks =
            await _bookmarkRepository.getBookmarks(searchValue: event.value);
        emit(
          state.copyWith(
            getBookmarksStatus: LoadingStatus.done,
            searchedBookmarks: searchedBookmarks,
          ),
        );
      } catch (e) {
        addError(e);
        emit(state.copyWith(getBookmarksStatus: LoadingStatus.error));
      }
    } else {
      emit(state.copyWith(searchedBookmarks: List.from(state.bookmarks)));
    }
  }

  Future<void> _onScrollMoreBookmarks(
    ScrollMoreBookmarks event,
    Emitter<BookmarkState> emit,
  ) async {
    try {
      emit(state.copyWith(getBookmarkMoreStatus: LoadingStatus.loading));
      final moreBookmarks = await _bookmarkRepository.getBookmarks(
        pageNumber: state.currentPageAll,
      );
      if (moreBookmarks.isEmpty) {
        emit(
          state.copyWith(
            getBookmarkMoreStatus: LoadingStatus.done,
            bookmarks: [...state.bookmarks, ...moreBookmarks]
              ..toSet()
              ..toList(),
          ),
        );
      } else {
        emit(
          state.copyWith(
            getBookmarkMoreStatus: LoadingStatus.done,
            bookmarks: [...state.bookmarks, ...moreBookmarks]
              ..toSet()
              ..toList(),
            currentPageAll: state.currentPageAll + 1,
          ),
        );
      }

      emit(state.copyWith(searchedBookmarks: List.from(state.bookmarks)));
    } catch (e) {
      addError(e);
      emit(state.copyWith(getBookmarkMoreStatus: LoadingStatus.error));
    }
  }

  void _onSearchButtonPressed(
    SearchButtonPressed event,
    Emitter<BookmarkState> emit,
  ) {
    if (state.isSearching) {
      emit(
        state.copyWith(
          searchedBookmarks: List.from(state.bookmarks),
        ),
      );
    }
    emit(state.copyWith(isSearching: !state.isSearching));
  }
}
