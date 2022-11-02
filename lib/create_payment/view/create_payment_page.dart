import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/payment.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/create_payment/create_payment.dart';
import 'package:pbl6_mobile/create_payment/view/webview_payment_page.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:widgets/widgets.dart';

class CreatePaymentPage extends StatelessWidget {
  const CreatePaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePaymentBloc(
        paymentRepository: context.read<PaymentRepository>(),
      ),
      child: const CreatePaymentView(),
    );
  }
}

class CreatePaymentView extends StatelessWidget {
  const CreatePaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePaymentBloc, CreatePaymentState>(
      listener: (context, state) {
        if (state.createPaymentStatus == LoadingStatus.done) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => WebviewPaymentPage(
                url: state.urlRepsonse,
              ),
            ),
          );
        }
        if (state.createPaymentStatus == LoadingStatus.error) {
          ToastHelper.showToast('Thao tác thất bại, vui lòng thử lại');
        }
      },
      child: DissmissFocus(
        child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(
                    builder: (context) {
                      final formatter = CurrencyTextInputFormatter(
                        locale: 'vi',
                        symbol: 'VND',
                        decimalDigits: 0,
                      );
                      return AppTextField(
                        inputFormatters: [formatter],
                        labelText: 'Số tiền muốn nạp',
                        onChanged: (_) => context.read<CreatePaymentBloc>().add(
                              AmountChanged(
                                formatter.getUnformattedValue().toString(),
                              ),
                            ),
                        keyboardType: TextInputType.number,
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<CreatePaymentBloc, CreatePaymentState>(
                    builder: (context, state) {
                      return AppDropDownField<String>(
                        value: state.selectedBankCode.isEmpty
                            ? null
                            : state.selectedBankCode,
                        items: state.bankCodes
                            .map<DropdownMenuItem<String>>(
                              (bankCode) => DropdownMenuItem(
                                value: bankCode.code,
                                child: Text(bankCode.description),
                              ),
                            )
                            .toList(),
                        labelText: 'Ngân hàng',
                        onChanged: (bankCode) {
                          if (bankCode != null) {
                            context
                                .read<CreatePaymentBloc>()
                                .add(BankCodeChanged(bankCode));
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  AppTextField(
                    labelText: 'Mô tả',
                    onChanged: (desc) => context
                        .read<CreatePaymentBloc>()
                        .add(OrderDescriptionChanged(desc)),
                  ),
                  const SizedBox(height: 24),
                  Builder(
                    builder: (context) {
                      final createPaymentStatus = context.select(
                        (CreatePaymentBloc bloc) =>
                            bloc.state.createPaymentStatus,
                      );
                      return createPaymentStatus == LoadingStatus.loading
                          ? const CircularProgressIndicator()
                          : FilledButton(
                              child: const Text('Nạp tiền'),
                              onPressed: () => context
                                  .read<CreatePaymentBloc>()
                                  .add(CreatePaymentSumitted()),
                            );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
