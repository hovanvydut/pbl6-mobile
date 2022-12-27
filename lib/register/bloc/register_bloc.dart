import 'dart:async';

import 'package:auth/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:models/models.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const RegisterState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<DisplayNameChanged>(_onDisplayNameChanged);

    on<ConfirmationPasswordChanged>(_onConfirmationPasswordChanged);
    on<ShowHidePasswordPressed>(_onShowHidePasswordPressed);
    on<ShowHideConfirmationPasswordPressed>(
      _onShowHideConfirmationPasswordPressed,
    );
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<RolePressed>(_onRolePressed);
  }

  final AuthRepository _authRepository;

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
            state.displayName,
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
            state.displayName,
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
          state.displayName,
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
            state.displayName,
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
      final phoneNumber = Faker().phoneNumber.us();
      final indentityNumber = Faker().phoneNumber.us();
      await _authRepository.register(
        address: 'Đà Nẵng',
        avatar:
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png',
        displayName: state.displayName.value,
        email: state.email.value,
        identityNumber: indentityNumber,
        phoneNumber: phoneNumber,
        roleId: state.selectedRole?.index ?? 0 + 1,
        wardId: 6351,
        password: state.password.value,
      );
      emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      addError(e);
      emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
      rethrow;
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

  void _onDisplayNameChanged(
    DisplayNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final displayName = DisplayName.dirty(event.displayName);
    emit(
      state.copyWith(
        displayName: displayName,
        formStatus: Formz.validate(
          [
            state.confirmationPassword,
            state.email,
            displayName,
            state.password,
          ],
        ),
      ),
    );
  }

  void _onRolePressed(RolePressed event, Emitter<RegisterState> emit) {
    emit(state.copyWith(selectedRole: event.role));
  }
}
