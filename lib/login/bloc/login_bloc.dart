import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:models/models.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ShowHidePasswordPressed>(_onShowHidePasswordPressed);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onEmailChanged(
    EmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        password: state.password,
        formStatus: Formz.validate(
          [
            email,
            state.password,
          ],
        ),
      ),
    );
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        email: state.email,
        password: password,
        formStatus: Formz.validate(
          [
            state.email,
            password,
          ],
        ),
      ),
    );
  }

  FutureOr<void> _onShowHidePasswordPressed(
    ShowHidePasswordPressed event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(isHidePassword: !state.isHidePassword));
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
      await Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
    }
  }
}
