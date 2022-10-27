part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class GetUserPosts extends PostEvent {}

class DeleteUserPost extends PostEvent {
  const DeleteUserPost(this.post);
  final Post post;

  @override
  List<Object?> get props => [post];
}

class GetAllPosts extends PostEvent {}
