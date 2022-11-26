import 'package:config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/post/post.dart';
import 'package:pbl6_mobile/uptop/uptop.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:uptop/repositories/uptop_repository.dart';
import 'package:widgets/widgets.dart';

class CreateUptopDialog extends StatelessWidget {
  const CreateUptopDialog({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UptopBloc(
        post: post,
        uptopRepository: context.read<UptopRepository>(),
        configRepository: context.read<ConfigRepository>(),
      )..add(CreateDialogStarted()),
      child: const CreateUptopDialogView(),
    );
  }
}

class CreateUptopDialogView extends StatefulWidget {
  const CreateUptopDialogView({super.key});

  @override
  State<CreateUptopDialogView> createState() => _CreateUptopDialogViewState();
}

class _CreateUptopDialogViewState extends State<CreateUptopDialogView> {
  late final TextEditingController _dateTextEditingController;
  late final TextEditingController _noOfDayTextEditingController;

  @override
  void initState() {
    super.initState();
    _dateTextEditingController =
        TextEditingController(text: DateTime.now().yMd);
    _noOfDayTextEditingController = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    _dateTextEditingController.dispose();
    _noOfDayTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UptopBloc, UptopState>(
      listenWhen: (previous, current) =>
          previous.uptopLoadingStatus != current.uptopLoadingStatus,
      listener: (context, state) {
        if (state.uptopLoadingStatus == LoadingStatus.done) {
          ToastHelper.showToast('Đẩy bài viết ưu tiên thành công');
          context.read<PostBloc>().add(GetUserPosts());
          Navigator.pop(context);
        }
        if (state.uptopLoadingStatus == LoadingStatus.error) {
          ToastHelper.showToast('Đẩy bài viết ưu tiên thất bại, xin thử lại');
        }
      },
      child: DismissFocus(
        child: AlertDialog(
          backgroundColor: context.colorScheme.surface,
          title: Text(
            'Đẩy bài viết lên tin ưu tiên',
            style: context.theme.textTheme.titleLarge!.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              AppTextField(
                textEditingController: _noOfDayTextEditingController,
                labelText: 'Số ngày đẩy tin ưu tiên',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (int.tryParse(value) != null) {
                    context
                        .read<UptopBloc>()
                        .add(NumOfDayChanged(int.tryParse(value)!));
                    return;
                  }
                },
              ),
              const SizedBox(height: 24),
              Builder(
                builder: (context) {
                  final startDate =
                      context.select((UptopBloc bloc) => bloc.state.startDate);
                  return AppTextField(
                    textEditingController: _dateTextEditingController,
                    labelText: 'Ngày bắt đầu đẩy tin',
                    suffixIcon: IconButton(
                      icon: Assets.icons.calendar2
                          .svg(color: context.colorScheme.onSurface),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: startDate,
                          firstDate: DateTime(startDate.year - 1),
                          lastDate: DateTime(startDate.year + 1),
                        ).then((pickedDate) {
                          if (pickedDate != null) {
                            _dateTextEditingController.text = pickedDate.yMd;
                            context
                                .read<UptopBloc>()
                                .add(StartDateChanged(pickedDate));
                          }
                        });
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Số tiền cần thanh toán',
                style: context.textTheme.titleMedium!.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Builder(
                builder: (context) {
                  final totalPrice =
                      context.select((UptopBloc bloc) => bloc.state.totalPrice);
                  return Text(
                    totalPrice.inSimpleCurrency,
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  );
                },
              )
            ],
          ),
          actions: [
            FilledButton(
              child: const Text('Đẩy ngay'),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                context.read<UptopBloc>().add(UptopSubmitted());
              },
            ),
            ElevatedButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
