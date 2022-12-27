part of '../../authentication/bloc/authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.user,
    this.permissions = const <Permission>[],
  });

  final User? user;
  final List<Permission> permissions;

  @override
  List<Object?> get props => [user, permissions];
}

class Unknown extends AuthenticationState {
  const Unknown();
}

class Authenticated extends AuthenticationState {
  const Authenticated({super.user, super.permissions});
}

class Unauthenticated extends AuthenticationState {
  const Unauthenticated()
      : super(user: null, permissions: const <Permission>[]);
}

class EndSession extends AuthenticationState {
  const EndSession() : super(user: null, permissions: const <Permission>[]);
}
