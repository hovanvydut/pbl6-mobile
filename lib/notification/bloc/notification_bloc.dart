import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:notification/notification.dart';
import 'package:pbl6_mobile/app/app.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({required NotificationRepository notificationRepository})
      : _notificationRepository = notificationRepository,
        super(const NotificationState()) {
    on<PageStarted>(_onPageStarted);
    on<ReadNotification>(_onReadNotification);
    on<LoadMoreTodayNotification>(_onLoadMoreTodayNotification);
    on<LoadMoreAllNotification>(_onLoadMoreAllNotification);
    on<ReadAllNotifications>(_onReadAllNotifications);

    on<SearchModeToggled>(_onSearchModdeToggled);

    on<GetNotifications>(_onGetNotifications);
    on<SearchValueChanged>(_onValueChanged);
  }

  final NotificationRepository _notificationRepository;

  Future<void> _onPageStarted(
    PageStarted event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    try {
      final notifications =
          await _notificationRepository.getNotifications(today: false);
      final todayNotifications =
          await _notificationRepository.getNotifications(today: true);

      emit(
        state.copyWith(
          todayNotifications: todayNotifications,
          loadingStatus: LoadingStatus.done,
          currentPage: state.currentPage + 1,
          todayCurrentPage: state.todayCurrentPage + 1,
          notifications: notifications,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
      rethrow;
    }
  }

  Future<void> _onReadNotification(
    ReadNotification event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await _notificationRepository.readNotification(event.notificiation.id);
      final indexInAll = state.notifications.indexOf(event.notificiation);
      state.notifications[indexInAll] =
          event.notificiation.copyWith(hasRead: true);
      if (state.todayNotifications.isNotEmpty) {
        final todayIndex =
            state.todayNotifications.indexOf(event.notificiation);
        state.todayNotifications[todayIndex] =
            event.notificiation.copyWith(hasRead: true);
      }

      emit(
        state.copyWith(
          todayNotifications: List.from(state.todayNotifications),
          notifications: List.from(state.notifications),
          actionStatus: LoadingStatus.done,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(actionStatus: LoadingStatus.error));
      rethrow;
    }
  }

  Future<void> _onLoadMoreTodayNotification(
    LoadMoreTodayNotification event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(isLoadingMore: true));
    try {
      final todayNotifications = await _notificationRepository.getNotifications(
        today: true,
        pageNumber: state.todayCurrentPage,
        searchValue: state.searchValue,
      );
      emit(
        state.copyWith(
          todayNotifications: [
            ...state.todayNotifications,
            ...todayNotifications
          ],
          todayCurrentPage: state.todayCurrentPage + 1,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(isLoadingMore: false));
      rethrow;
    }
  }

  Future<void> _onLoadMoreAllNotification(
    LoadMoreAllNotification event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(isLoadingMore: true));
    try {
      final notifications = await _notificationRepository.getNotifications(
        today: false,
        pageNumber: state.currentPage,
        searchValue: state.searchValue,
      );
      emit(
        state.copyWith(
          notifications: [...state.notifications, ...notifications],
          currentPage: state.currentPage + 1,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(isLoadingMore: false));
      rethrow;
    }
  }

  Future<void> _onReadAllNotifications(
    ReadAllNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await _notificationRepository.readAllNotifications();
      emit(
        state.copyWith(
          todayNotifications: state.todayNotifications
              .map((notification) => notification.copyWith(hasRead: true))
              .toList(),
          notifications: state.notifications
              .map((notification) => notification.copyWith(hasRead: true))
              .toList(),
          actionStatus: LoadingStatus.done,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(actionStatus: LoadingStatus.error));
      rethrow;
    }
  }

  Future<void> _onGetNotifications(
    GetNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
        currentPage: 1,
        todayCurrentPage: 1,
      ),
    );
    try {
      final notifications = await _notificationRepository.getNotifications(
        today: false,
        pageNumber: state.currentPage,
      );
      final todayNotifications = await _notificationRepository.getNotifications(
        today: true,
        pageNumber: state.todayCurrentPage,
      );

      emit(
        state.copyWith(
          todayNotifications: todayNotifications,
          notifications: notifications,
          loadingStatus: LoadingStatus.done,
          currentPage: state.currentPage + 1,
          todayCurrentPage: state.todayCurrentPage + 1,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
      rethrow;
    }
  }

  Future<void> _onValueChanged(
    SearchValueChanged event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          searchValue: event.value,
          loadingStatus: LoadingStatus.loading,
        ),
      );
      final notifications = await _notificationRepository.getNotifications(
        today: false,
        searchValue: event.value,
      );
      emit(
        state.copyWith(
          notifications: notifications,
          loadingStatus: LoadingStatus.done,
        ),
      );
    } catch (e) {
      addError(e);
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
        ),
      );
      rethrow;
    }
  }

  void _onSearchModdeToggled(
    SearchModeToggled event,
    Emitter<NotificationState> emit,
  ) {
    emit(state.copyWith(searchMode: !state.searchMode, searchValue: ''));
  }
}
