part of '../../authentication/bloc/authentication_bloc.dart';

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

class EndSession extends AuthenticationState {
  const EndSession() : super(user: null);
}
