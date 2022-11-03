import 'package:address/address.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/post/post.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required PostBloc postBloc,
    required AddressRepository addressRepository,
  })  : _postBloc = postBloc,
        _addressRepository = addressRepository,
        super(const HomeState()) {
    on<HomePageStarted>(_onHomePageStarted);
    add(HomePageStarted());
  }

  final AddressRepository _addressRepository;
  final PostBloc _postBloc;

  Future<void> _onHomePageStarted(
    HomePageStarted event,
    Emitter<HomeState> emit,
  ) async {
    try {
      _postBloc.add(GetAllPosts());
      emit(state.copyWith(homeLoadingStatus: LoadingStatus.loading));
      final fetchedDistricts =
          await _addressRepository.getDistrictsByProvinceId(32);
      emit(
        state.copyWith(
          homeLoadingStatus: LoadingStatus.done,
          district: fetchedDistricts,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(homeLoadingStatus: LoadingStatus.error));
      rethrow;
    }
  }
}
