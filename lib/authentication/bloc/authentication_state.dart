part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState({this.user});

  final User? user;

  @override
  List<Object?> get props => [user];
}

class Unknown extends AuthenticationState {
  const Unknown();
}

class Authenticated extends AuthenticationState {
  const Authenticated({required User user}) : super(user: user);
}

class Unauthenticated extends AuthenticationState {
  const Unauthenticated() : super(user: null);
}
