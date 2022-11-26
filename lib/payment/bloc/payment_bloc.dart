import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:payment/payment.dart';
import 'package:pbl6_mobile/app/app.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({required PaymentRepository paymentRepository})
      : _paymentRepository = paymentRepository,
        super(const PaymentState()) {
    on<PaymentPageStarted>(_onPaymentPageStarted);
    on<GetPaymentHistory>(_onGetPaymentHistory);
    add(PaymentPageStarted());
  }

  final PaymentRepository _paymentRepository;

  Future<void> _onPaymentPageStarted(
    PaymentPageStarted event,
    Emitter<PaymentState> emit,
  ) async {
    try {
      emit(state.copyWith(pageLoadingStatus: LoadingStatus.loading));
      final debitHistoryList =
          await _paymentRepository.getPersonalDebitHistory();
      final creditHistoryList =
          await _paymentRepository.getPersonalCreditHistory();
      emit(
        state.copyWith(
          pageLoadingStatus: LoadingStatus.done,
          debitHistoryList: debitHistoryList,
          creditHistoryList: creditHistoryList,
          currentCreditPage: state.currentCreditPage + 1,
          currentDebitPage: state.currentDebitPage + 1,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(pageLoadingStatus: LoadingStatus.error));
      rethrow;
    }
  }

  void _onGetPaymentHistory(
    GetPaymentHistory event,
    Emitter<PaymentState> emit,
  ) {}
}
