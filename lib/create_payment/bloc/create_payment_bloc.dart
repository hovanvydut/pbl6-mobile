import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

part 'create_payment_event.dart';
part 'create_payment_state.dart';

class CreatePaymentBloc extends Bloc<CreatePaymentEvent, CreatePaymentState> {
  CreatePaymentBloc() : super(const CreatePaymentState()) {
    on<CreatePaymentStarted>(_onCreatePaymentStarted);
    on<AmountChanged>(_onAmountChanged);
    on<BankCodeChanged>(_onBankCodeChanged);
    on<OrderDescriptionChanged>(_onDescChanged);
    on<CreatePaymentSumitted>(_onSubmitted);
  }

  void _onCreatePaymentStarted(
    CreatePaymentStarted event,
    Emitter<CreatePaymentState> emit,
  ) {}

  void _onAmountChanged(
    AmountChanged event,
    Emitter<CreatePaymentState> emit,
  ) {}

  void _onBankCodeChanged(
    BankCodeChanged event,
    Emitter<CreatePaymentState> emit,
  ) {}

  void _onDescChanged(
    OrderDescriptionChanged event,
    Emitter<CreatePaymentState> emit,
  ) {}

  void _onSubmitted(
    CreatePaymentSumitted event,
    Emitter<CreatePaymentState> emit,
  ) {}
}
