part of 'user_post_bloc.dart';

abstract class UserPostEvent extends Equatable {
  const UserPostEvent();

  @override
  List<Object?> get props => [];
}

class GetUserPosts extends UserPostEvent {}

class DeleteUserPost extends UserPostEvent {
  const DeleteUserPost(this.post);
  final Post post;

  @override
  List<Object?> get props => [post];
}

class GetMoreUserPosts extends UserPostEvent {}
