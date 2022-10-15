import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:models/models.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmationPasswordChanged>(_onConfirmationPasswordChanged);
    on<ShowHidePasswordPressed>(_onShowHidePasswordPressed);
    on<ShowHideConfirmationPasswordPressed>(
      _onShowHideConfirmationPasswordPressed,
    );
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  void _onEmailChanged(
    EmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        formStatus: Formz.validate(
          [
            email,
            state.password,
            state.confirmationPassword,
          ],
        ),
      ),
    );
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password);
    if (state.confirmationPassword.pure) {
      emit(
        state.copyWith(
          password: password,
          formStatus: Formz.validate([
            state.email,
            password,
            state.confirmationPassword,
          ]),
        ),
      );
      return;
    }
    final confirmationPassword = ConfirmationPassword.dirty(
      password: password.value,
      value: state.confirmationPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmationPassword: confirmationPassword,
        formStatus: Formz.validate([
          state.email,
          password,
          confirmationPassword,
        ]),
      ),
    );
  }

  void _onConfirmationPasswordChanged(
    ConfirmationPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final confirmationPassword = ConfirmationPassword.dirty(
      password: state.password.value,
      value: event.confirmationPassword,
    );
    emit(
      state.copyWith(
        confirmationPassword: confirmationPassword,
        formStatus: Formz.validate(
          [
            confirmationPassword,
            state.email,
            state.password,
          ],
        ),
      ),
    );
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
      await Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
    }
  }

  void _onShowHidePasswordPressed(
    ShowHidePasswordPressed event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        isHidePassword: !state.isHidePassword,
      ),
    );
  }

  void _onShowHideConfirmationPasswordPressed(
    ShowHideConfirmationPasswordPressed event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        isHideConfirmationPassword: !state.isHideConfirmationPassword,
      ),
    );
  }
}
