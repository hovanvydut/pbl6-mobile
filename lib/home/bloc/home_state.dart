part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.district = const [],
    this.homeLoadingStatus = LoadingStatus.initial,
  });

  final List<District> district;
  final LoadingStatus homeLoadingStatus;

  @override
  List<Object?> get props => [district, homeLoadingStatus];

  HomeState copyWith({
    List<District>? district,
    LoadingStatus? homeLoadingStatus,
  }) {
    return HomeState(
      district: district ?? this.district,
      homeLoadingStatus: homeLoadingStatus ?? this.homeLoadingStatus,
    );
  }
}
