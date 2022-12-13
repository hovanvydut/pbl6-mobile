import 'dart:async';

import 'package:address/address.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:post/post.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required PostRepository postRepository,
    required AddressRepository addressRepository,
  })  : _addressRepository = addressRepository,
        _postRepository = postRepository,
        super(const HomeState()) {
    on<HomePageStarted>(_onHomePageStarted);
    on<LoadMoreAllPosts>(_onLoadMoreAllPosts);
    on<GetAllPosts>(_onGetAllPost);

    add(HomePageStarted());
  }

  final AddressRepository _addressRepository;
  final PostRepository _postRepository;

  Future<void> _onHomePageStarted(
    HomePageStarted event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(homeLoadingStatus: LoadingStatus.loading));
      final fetchedDistricts =
          await _addressRepository.getDistrictsByProvinceId(32);
      final allPosts = await _postRepository.getAllPosts();
      emit(
        state.copyWith(
          homeLoadingStatus: LoadingStatus.done,
          district: fetchedDistricts,
          allPosts: allPosts,
          currentPage: state.currentPage + 1,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(homeLoadingStatus: LoadingStatus.error));
      rethrow;
    }
  }

  Future<void> _onGetAllPost(
    GetAllPosts event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          homeLoadingStatus: LoadingStatus.loading,
          currentPage: 1,
        ),
      );
      final allPosts = await _postRepository.getAllPosts();
      emit(
        state.copyWith(
          homeLoadingStatus: LoadingStatus.done,
          allPosts: allPosts,
          currentPage: state.currentPage + 1,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(homeLoadingStatus: LoadingStatus.error));
      rethrow;
    }
  }

  Future<void> _onLoadMoreAllPosts(
    LoadMoreAllPosts event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (!state.canAllPostsLoadMore) return;
      emit(state.copyWith(loadMorePostStatus: LoadingStatus.loading));
      final allPosts = await _postRepository.getAllPosts(
        pageNumber: state.currentPage,
      );
      if (allPosts.isNotEmpty) {
        emit(
          state.copyWith(
            loadMorePostStatus: LoadingStatus.done,
            allPosts: [...state.allPosts, ...allPosts],
            currentPage: state.currentPage + 1,
          ),
        );
      }
      emit(
        state.copyWith(
          loadMorePostStatus: LoadingStatus.done,
          canAllPostsLoadMore: false,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(loadMorePostStatus: LoadingStatus.error));
      rethrow;
    }
  }
}
