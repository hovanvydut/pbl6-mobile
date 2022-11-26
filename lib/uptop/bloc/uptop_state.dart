part of 'uptop_bloc.dart';

class UptopState extends Equatable {
  const UptopState({
    required this.post,
    this.dialogLoadingStatus = LoadingStatus.initial,
    this.uptopLoadingStatus = LoadingStatus.initial,
    this.totalPrice = 0,
    this.configPrice = 0,
    required this.startDate,
    this.day = 1,
    this.uptopData,
  });
  final Post post;
  final LoadingStatus dialogLoadingStatus;
  final LoadingStatus uptopLoadingStatus;
  final int totalPrice;
  final int configPrice;
  final DateTime startDate;
  final int day;
  final UptopData? uptopData;

  @override
  List<Object?> get props {
    return [
      post,
      dialogLoadingStatus,
      uptopLoadingStatus,
      totalPrice,
      configPrice,
      startDate,
      day,
      uptopData,
    ];
  }

  UptopState copyWith({
    Post? post,
    LoadingStatus? dialogLoadingStatus,
    LoadingStatus? uptopLoadingStatus,
    int? totalPrice,
    int? configPrice,
    DateTime? startDate,
    int? day,
    UptopData? uptopData,
  }) {
    return UptopState(
      post: post ?? this.post,
      dialogLoadingStatus: dialogLoadingStatus ?? this.dialogLoadingStatus,
      uptopLoadingStatus: uptopLoadingStatus ?? this.uptopLoadingStatus,
      totalPrice: totalPrice ?? this.totalPrice,
      configPrice: configPrice ?? this.configPrice,
      startDate: startDate ?? this.startDate,
      day: day ?? this.day,
      uptopData: uptopData ?? this.uptopData,
    );
  }
}
