part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomePageStarted extends HomeEvent {}

class GetAllPosts extends HomeEvent {}

class LoadMoreAllPosts extends HomeEvent {}
