import 'package:flutter/material.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Thông tin chung',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        box16,
        const AppTextField(
          labelText: 'Tiêu đề ',
          hintText: 'Tiêu đề cho bài viết',
        ),
        box24,
        const AppTextField(
          labelText: 'Mô tả chung',
          hintText: 'Mô tả chung của bài viết',
        ),
      ],
    );
  }
}
