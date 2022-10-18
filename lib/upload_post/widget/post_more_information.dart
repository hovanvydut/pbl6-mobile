import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class PostMoreInformation extends StatelessWidget {
  const PostMoreInformation({
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
          'Thông tin thêm',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        box16,
        const AppTextField(
          labelText: 'Số người tối đã',
          keyboardType: TextInputType.number,
        ),
        box24,
        const AppTextField(
          labelText: 'Tiền cọc',
          keyboardType: TextInputType.number,
        ),
        box24,
        const AppTextField(labelText: 'Tiện ích khác'),
        box24,
        const AppTextField(
          labelText: 'Đối tượng cho thuê',
        ),
        box24,
        const AppTextField(
          labelText: 'Địa điểm gần đó',
          isFinalFieldInForm: true,
        ),
      ],
    );
  }
}
