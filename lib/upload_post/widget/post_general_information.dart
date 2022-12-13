import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/upload_post/upload_post.dart';
import 'package:widgets/widgets.dart';

class PostGeneralInformation extends StatelessWidget {
  const PostGeneralInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const box16 = SizedBox(
      height: 16,
    );
    const box24 = SizedBox(
      height: 24,
    );
    final uploadPostBlog = context.read<UploadUserPostBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Thông tin chung',
          style: context.textTheme.titleLarge,
        ),
        box16,
        Builder(
          builder: (context) {
            final title =
                context.select((UploadUserPostBloc bloc) => bloc.state.title);
            final errorText = title.invalid
                ? (title.error == LimitLengthFieldValidationError.empty
                    ? 'Tiêu đề không được để trống'
                    : 'Tiêu đề phải từ ${title.limitLength} ký tự trở lên')
                : null;
            return AppTextField(
              labelText: 'Tiêu đề ',
              hintText: 'Tiêu đề cho bài viết',
              onChanged: (title) => uploadPostBlog.add(TitleChanged(title)),
              errorText: errorText,
            );
          },
        ),
        box24,
        Builder(
          builder: (context) {
            log('buid');
            final description = context
                .select((UploadUserPostBloc bloc) => bloc.state.description);
            final errorText =
                description.invalid ? 'Mô tả chung không được để trống' : null;
            return AppTextField(
              labelText: 'Mô tả chung',
              hintText: 'Mô tả chung của bài viết',
              maxLines: null,
              onChanged: (description) =>
                  uploadPostBlog.add(SummaryDescriptionChanged(description)),
              errorText: errorText,
            );
          },
        ),
      ],
    );
  }
}
