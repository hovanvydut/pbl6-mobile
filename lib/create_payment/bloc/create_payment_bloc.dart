import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:payment/payment.dart';
import 'package:pbl6_mobile/app/app.dart';

part 'create_payment_event.dart';
part 'create_payment_state.dart';

class CreatePaymentBloc extends Bloc<CreatePaymentEvent, CreatePaymentState> {
  CreatePaymentBloc({
    required PaymentRepository paymentRepository,
  })  : _paymentRepository = paymentRepository,
        super(const CreatePaymentState()) {
    on<CreatePaymentPageStarted>(_onCreatePaymentPageStarted);
    on<AmountChanged>(_onAmountChanged);
    on<BankCodeChanged>(_onBankCodeChanged);
    on<OrderDescriptionChanged>(_onDescChanged);
    on<CreatePaymentSumitted>(_onSubmitted);
    add(CreatePaymentPageStarted());
  }

  final PaymentRepository _paymentRepository;

  Future<void> _onCreatePaymentPageStarted(
    CreatePaymentPageStarted event,
    Emitter<CreatePaymentState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingDataStatus: LoadingStatus.loading));
      final bankCodes = await _paymentRepository.getBankCodes();
      emit(
        state.copyWith(
          bankCodes: bankCodes,
          loadingDataStatus: LoadingStatus.done,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(loadingDataStatus: LoadingStatus.error));
      rethrow;
    }
  }

  void _onAmountChanged(
    AmountChanged event,
    Emitter<CreatePaymentState> emit,
  ) {
    final amount = int.tryParse(event.amount) ?? 0;
    emit(state.copyWith(amount: amount));
  }

  void _onBankCodeChanged(
    BankCodeChanged event,
    Emitter<CreatePaymentState> emit,
  ) {
    emit(state.copyWith(selectedBankCode: event.bankCode));
  }

  void _onDescChanged(
    OrderDescriptionChanged event,
    Emitter<CreatePaymentState> emit,
  ) {
    emit(state.copyWith(description: event.desc));
  }

  Future<void> _onSubmitted(
    CreatePaymentSumitted event,
    Emitter<CreatePaymentState> emit,
  ) async {
    try {
      emit(state.copyWith(createPaymentStatus: LoadingStatus.loading));
      final url = await _paymentRepository.createPayment(
        amount: state.amount,
        bankCode: state.selectedBankCode,
        desc: state.description,
      );
      emit(
        state.copyWith(
          createPaymentStatus: LoadingStatus.done,
          urlRepsonse: url,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(createPaymentStatus: LoadingStatus.error));
      rethrow;
    }
  }
}
