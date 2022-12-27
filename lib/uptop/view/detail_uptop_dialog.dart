import 'package:config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/uptop/uptop.dart';
import 'package:uptop/repositories/uptop_repository.dart';
import 'package:widgets/widgets.dart';

class DetailUptopDialog extends StatelessWidget {
  const DetailUptopDialog({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UptopBloc(
        post: post,
        uptopRepository: context.read<UptopRepository>(),
        configRepository: context.read<ConfigRepository>(),
      )..add(DetailDialogStarted()),
      child: const DetailUptopDialogView(),
    );
  }
}

class DetailUptopDialogView extends StatelessWidget {
  const DetailUptopDialogView({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colorScheme.surface,
      title: Text(
        'Chi tiêt đẩy tin',
        style: context.theme.textTheme.titleLarge?.copyWith(
          color: context.colorScheme.onSurface,
        ),
      ),
      content: BlocBuilder<UptopBloc, UptopState>(
        builder: (context, state) {
          final loadingStatus = state.dialogLoadingStatus;
          if (loadingStatus == LoadingStatus.loading) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Center(child: CircularProgressIndicator()),
              ],
            );
          }
          if (loadingStatus == LoadingStatus.done) {
            final uptopData = state.uptopData;
            final noOfUptopDay =
                uptopData!.endTime.day - uptopData.startTime.day;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField(
                  initialValue: '$noOfUptopDay',
                  labelText: 'Số ngày đẩy tin ưu tiên',
                  readOnly: true,
                ),
                const SizedBox(height: 24),
                AppTextField(
                  initialValue:
                      '${uptopData.startTime.yMd} - ${uptopData.endTime.yMd}',
                  labelText: 'Thời gian đẩy tin',
                  readOnly: true,
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
