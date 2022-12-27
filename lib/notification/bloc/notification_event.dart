// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class PageStarted extends NotificationEvent {}

class ReadAllNotifications extends NotificationEvent {}

class SearchModeToggled extends NotificationEvent {}

class GetNotifications extends NotificationEvent {}

class SearchValueChanged extends NotificationEvent {
  const SearchValueChanged({
    required this.value,
  });
  final String value;

  @override
  List<Object?> get props => [value];
}

class LoadMoreAllNotification extends NotificationEvent {}

class LoadMoreTodayNotification extends NotificationEvent {}

class ReadNotification extends NotificationEvent {
  const ReadNotification({
    required this.notificiation,
  });
  final NotificationData notificiation;

  @override
  List<Object?> get props => [notificiation];
}
