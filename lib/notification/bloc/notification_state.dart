part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.todayNotifications = const <NotificationData>[],
    this.notifications = const <NotificationData>[],
    this.searchValue = '',
    this.currentPage = 1,
    this.todayCurrentPage = 1,
    this.loadingStatus = LoadingStatus.initial,
    this.isLoadingMore = false,
    this.actionStatus = LoadingStatus.initial,
    this.searchMode = false,
  });

  final List<NotificationData> todayNotifications;
  final List<NotificationData> notifications;
  final String searchValue;
  final int currentPage;
  final int todayCurrentPage;
  final bool searchMode;
  final bool isLoadingMore;

  final LoadingStatus loadingStatus;
  final LoadingStatus actionStatus;

  @override
  List<Object?> get props {
    return [
      todayNotifications,
      notifications,
      searchValue,
      searchMode,
      isLoadingMore,
      currentPage,
      todayCurrentPage,
      loadingStatus,
      actionStatus,
    ];
  }

  NotificationState copyWith({
    List<NotificationData>? notifications,
    List<NotificationData>? todayNotifications,
    String? searchValue,
    int? currentPage,
    int? todayCurrentPage,
    bool? searchMode,
    bool? isLoadingMore,
    LoadingStatus? loadingStatus,
    LoadingStatus? actionStatus,
  }) {
    return NotificationState(
      todayNotifications: todayNotifications ?? this.todayNotifications,
      notifications: notifications ?? this.notifications,
      searchValue: searchValue ?? this.searchValue,
      currentPage: currentPage ?? this.currentPage,
      todayCurrentPage: todayCurrentPage ?? this.todayCurrentPage,
      searchMode: searchMode ?? this.searchMode,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      actionStatus: actionStatus ?? this.actionStatus,
    );
  }
}
