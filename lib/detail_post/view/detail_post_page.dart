import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:pbl6_mobile/detail_post/detail_post.dart';
import 'package:pbl6_mobile/review_post/review_post.dart';
import 'package:post/post.dart';

class DetailPostPage extends StatelessWidget {
  const DetailPostPage({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailPostCubit(
        post: post,
        postRepository: context.read<PostRepository>(),
      ),
      child: const DetailPostView(),
    );
  }
}

class DetailPostView extends StatelessWidget {
  const DetailPostView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return BlocListener<DetailPostCubit, DetailUserPostState>(
      listenWhen: (previous, current) =>
          previous.post.authorInfo?.id != current.post.authorInfo?.id,
      listener: (context, state) {
        final user = context.read<AuthenticationBloc>().state.user;
        if (user != null && user.id == state.post.authorInfo!.id) {
          context.showSnackBar(message: 'Bạn đang xem bài viết của chính mình');
        }
      },
      child: BlocBuilder<DetailPostCubit, DetailUserPostState>(
        builder: (context, state) {
          final post = state.post;
          final loadingStatus = state.loadingStatus;
          return loadingStatus == LoadingStatus.loading
              ? const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Scaffold(
                  appBar: DetailPostAppBar(post: post),
                  body: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              DetailPostImage(post: post),
                              const SizedBox(height: 8),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    DetailPostBasicInformation(post: post),
                                    const SizedBox(height: 16),
                                    DetailPostMoreInformation(post: post),
                                    const SizedBox(height: 8),
                                    Divider(
                                      endIndent: 24,
                                      indent: 24,
                                      color: theme.colorScheme.outline
                                          .withOpacity(0.3),
                                    ),
                                    const SizedBox(height: 8),
                                    DetailPostUtilInformation(post: post),
                                    Divider(
                                      height: 32,
                                      color: theme.colorScheme.outline
                                          .withOpacity(0.3),
                                    ),
                                    DetailPostDescription(post: post),
                                    const SizedBox(height: 24),
                                    DetailPostAddressInformation(post: post),
                                    const SizedBox(height: 16),
                                    DetailPostCreatedDateInfo(post: post),
                                    DetailPostAuthorInfo(post: post),
                                    DetailPostOtherUtilsInfo(post: post),
                                    DetailPostNearbyPlacesInfo(post: post),
                                    ReviewPostSession(post: post),
                                  ],
                                ),
                              ),
                              const RelatedPostHorizonalList()
                            ],
                          ),
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          final user =
                              context.watch<AuthenticationBloc>().state.user;
                          return DetailPostConnectionPanel(
                            isLogged: user != null,
                            visiable: user?.id != post.authorInfo?.id,
                          );
                        },
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
