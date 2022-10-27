part of 'search_filter_bloc.dart';

abstract class SearchFilterState extends Equatable {
  const SearchFilterState();

  @override
  List<Object?> get props => [];
}

class SearchFilterInitial extends SearchFilterState {}
