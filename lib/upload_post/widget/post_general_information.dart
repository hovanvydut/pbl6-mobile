import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final uploadPostBlog = context.read<UploadPostBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Thông tin chung',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        box16,
        AppTextField(
          labelText: 'Tiêu đề ',
          hintText: 'Tiêu đề cho bài viết',
          onChanged: (title) => uploadPostBlog.add(TitleChanged(title)),
        ),
        box24,
        AppTextField(
          labelText: 'Mô tả chung',
          hintText: 'Mô tả chung của bài viết',
          onChanged: (description) =>
              uploadPostBlog.add(SummaryDescriptionChanged(description)),
        ),
      ],
    );
  }
}
