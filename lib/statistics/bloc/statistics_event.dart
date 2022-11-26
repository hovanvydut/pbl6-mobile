part of 'statistics_bloc.dart';

abstract class StatisticsEvent extends Equatable {
  const StatisticsEvent();

  @override
  List<Object?> get props => [];
}

class PageStarted extends StatisticsEvent {}

class PostStatisticsTypeSelected extends StatisticsEvent {
  const PostStatisticsTypeSelected(this.key);

  final String key;

  @override
  List<Object?> get props => [key];
}

class DateRangeSelected extends StatisticsEvent {
  const DateRangeSelected({required this.fromDate, required this.toDate});

  final DateTime fromDate;
  final DateTime toDate;

  @override
  List<Object?> get props => [fromDate, toDate];
}

class ShowDetailStatisticsPressed extends StatisticsEvent {
  const ShowDetailStatisticsPressed(this.date);

  final String date;

  @override
  List<Object?> get props => [date];
}
