import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:payment/payment.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:pbl6_mobile/payment/payment.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentBloc(
        paymentRepository: context.read<PaymentRepository>(),
      ),
      child: const PaymentView(),
    );
  }
}

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Assets.icons.arrorLeft.svg(
            color: context.colorScheme.onSurface,
            height: 32,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text('Số dư tài khoản'),
        centerTitle: true,
        actions: [
          PermissionWrapper(
            permission: Permission.vnpCreatePayment,
            child: IconButton(
              icon: Assets.icons.add.svg(
                color: context.colorScheme.onSurface,
                height: 28,
              ),
              onPressed: () => context.pushToChild(AppRouter.createPayment),
            ),
          ),
        ],
      ),
      body: Column(
        children: const [
          CurrentCreditCard(),
          Expanded(child: HistoryPanel()),
        ],
      ),
    );
  }
}

class CurrentCreditCard extends StatelessWidget {
  const CurrentCreditCard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationBloc>().state.user;
    final currentCredit =
        user!.currentCredit != null ? user.currentCredit! / 100 : 0;
    return Container(
      margin: const EdgeInsets.all(16),
      height: context.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: context.colorScheme.tertiaryContainer,
      ),
      alignment: Alignment.center,
      child: Text(
        'Số dư trong tài khoản '
        '${currentCredit.toStringAsFixed(0)} đồng',
        style: context.textTheme.titleMedium,
      ),
    );
  }
}

class HistoryPanel extends StatefulWidget {
  const HistoryPanel({super.key});

  @override
  State<HistoryPanel> createState() => _HistoryPanelState();
}

class _HistoryPanelState extends State<HistoryPanel> {
  late final ValueNotifier<int> _currentTabNotifier;

  @override
  void initState() {
    super.initState();
    _currentTabNotifier = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    _currentTabNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final pageLoadingStatus =
            context.select((PaymentBloc bloc) => bloc.state.pageLoadingStatus);
        if (pageLoadingStatus == LoadingStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (pageLoadingStatus == LoadingStatus.error) {
          return const Center(
            child: Text('Lỗi vui lòng thử lại'),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16) +
                  const EdgeInsets.only(top: 8),
              child: Text(
                'Lịch sử giao dịch',
                style: context.textTheme.titleLarge?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12) +
                  const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  ValueListenableBuilder<int>(
                    valueListenable: _currentTabNotifier,
                    builder: (context, currentIndex, child) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _currentTabNotifier.value = 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                AnimatedDefaultTextStyle(
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: currentIndex == 0
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .outline
                                                .withOpacity(0.5),
                                      ),
                                  duration: const Duration(milliseconds: 200),
                                  child: const Text('Tiền vào'),
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  height: 6,
                                  width: 6,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: currentIndex == 0
                                        ? context.colorScheme.primary
                                        : Colors.transparent,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  ValueListenableBuilder<int>(
                    valueListenable: _currentTabNotifier,
                    builder: (context, currentIndex, child) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _currentTabNotifier.value = 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                AnimatedDefaultTextStyle(
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: currentIndex == 1
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .outline
                                                .withOpacity(0.5),
                                      ),
                                  duration: const Duration(milliseconds: 200),
                                  child: const Text('Tiền ra'),
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  height: 6,
                                  width: 6,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: currentIndex == 1
                                        ? context.colorScheme.primary
                                        : Colors.transparent,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<int>(
                valueListenable: _currentTabNotifier,
                builder: (context, currentIndex, child) {
                  if (currentIndex == 0) {
                    return const CreditHistoryListView();
                  } else {
                    return const DebitHistoryListView();
                  }
                },
              ),
            )
          ],
        );
      },
    );
  }
}

class CreditHistoryListView extends StatelessWidget {
  const CreditHistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final creditHistoryList =
            context.select((PaymentBloc bloc) => bloc.state.creditHistoryList);
        if (creditHistoryList.isEmpty) {
          return const Center(
            child: Text('Bạn không thực hiện giao dịch nạp tiền nào'),
          );
        }
        return ListView.builder(
          itemCount: creditHistoryList.length,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          itemBuilder: (context, index) {
            final creditHistory = creditHistoryList[index];
            final descriptionHistory = creditHistory.orderInfo.split(' | ')[1];
            return ListTile(
              leading: creditHistory.isSuccessful
                  ? Assets.icons.circleCheck.svg(
                      color: Colors.green,
                      height: 28,
                    )
                  : Assets.icons.circleWarning.svg(
                      color: context.colorScheme.error,
                      height: 28,
                    ),
              title: Text(descriptionHistory),
              subtitle: Text.rich(
                TextSpan(
                  text: creditHistory.createdAt.toLocal().yMdHms,
                  children: [
                    TextSpan(
                      text: '\n${creditHistory.transactionStatus}',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: creditHistory.isSuccessful
                            ? Colors.green
                            : context.colorScheme.error,
                      ),
                    )
                  ],
                ),
              ),
              trailing: Text(
                (creditHistory.amount / 1000).inSimpleCurrency,
                style: context.textTheme.labelLarge?.copyWith(
                  color: creditHistory.isSuccessful
                      ? Colors.green
                      : context.colorScheme.error,
                ),
              ),
              isThreeLine: true,
            );
          },
        );
      },
    );
  }
}

class DebitHistoryListView extends StatelessWidget {
  const DebitHistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final debitHistoryList =
            context.select((PaymentBloc bloc) => bloc.state.debitHistoryList);
        if (debitHistoryList.isEmpty) {
          return const Center(
            child: Text(
              'Bạn không thực hiện giao dịch tiêu tiền nào',
            ),
          );
        }
        return ListView.builder(
          itemCount: debitHistoryList.length,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          itemBuilder: (context, index) {
            final debitHistory = debitHistoryList[index];
            return ListTileTheme(
              child: ListTile(
                leading: Assets.icons.circleCheck.svg(color: Colors.green),
                title: Text(debitHistory.description),
                subtitle: Text(debitHistory.createdAt.toLocal().yMdHms),
                trailing: Text(
                  debitHistory.amount.inSimpleCurrency,
                  style: context.textTheme.labelLarge?.copyWith(
                    color: Colors.green,
                  ),
                ),
                isThreeLine: true,
              ),
            );
          },
        );
      },
    );
  }
}
