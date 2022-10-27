import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_filter_event.dart';
part 'search_filter_state.dart';

class SearchFilterBloc extends Bloc<SearchFilterEvent, SearchFilterState> {
  SearchFilterBloc() : super(SearchFilterInitial()) {
    on<SearchFilterEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
