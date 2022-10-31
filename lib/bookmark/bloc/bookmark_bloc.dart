import 'dart:async';

import 'package:bookmark/bookmark.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc({required BookmarkRepository bookmarkRepository})
      : _bookmarkRepository = bookmarkRepository,
        super(const BookmarkState()) {
    on<GetBookmarks>(_onGetBookmarks);
    on<AddBookmark>(_onAddBookmark);
    on<DeleteBookmark>(_onDeleteBookmark);
    on<SearchBookmark>(_onSearchBookmark);
    on<ScrollMoreBookmarks>(_onScrollMoreBookmarks);
    add(GetBookmarks());
  }

  final BookmarkRepository _bookmarkRepository;

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
          addBookmarkStatus: LoadingStatus.done,
        ),
      );
    } catch (e) {
      addError(e);
      emit(
        state.copyWith(
          addBookmarkStatus: LoadingStatus.error,
          bookmarks:
              state.bookmarks.where((post) => post != event.post).toList(),
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
          bookmarks:
              state.bookmarks.where((post) => post != event.post).toList(),
        ),
      );
    } catch (e) {
      addError(e);
      emit(
        state.copyWith(
          deleteBookmarkStatus: LoadingStatus.error,
          bookmarks: [...state.bookmarks, event.post],
        ),
      );
    }
  }

  Future<void> _onSearchBookmark(
    SearchBookmark event,
    Emitter<BookmarkState> emit,
  ) async {
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
  }

  Future<void> _onScrollMoreBookmarks(
    ScrollMoreBookmarks event,
    Emitter<BookmarkState> emit,
  ) async {
    try {
      emit(state.copyWith(getBookmarkMoreStatus: LoadingStatus.loading));
      final moreBookmarks = await _bookmarkRepository.getBookmarks();
      emit(
        state.copyWith(
          getBookmarkMoreStatus: LoadingStatus.done,
          bookmarks: [...state.bookmarks, ...moreBookmarks],
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(getBookmarkMoreStatus: LoadingStatus.error));
    }
  }
}
