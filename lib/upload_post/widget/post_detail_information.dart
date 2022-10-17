import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class PostDetailInformation extends StatelessWidget {
  const PostDetailInformation({
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
          'Thông tin chi tiết',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        box16,
        AppDropDownField<String>(
          labelText: 'Loại phòng',
          items: const [
            DropdownMenuItem(
              child: Text('Phòng cho thuê'),
            )
          ],
          onChanged: (value) {},
        ),
        box24,
        const AppTextField(
          labelText: 'Giá',
        ),
        box24,
        const AppTextField(
          labelText: 'Diện tích',
        )
      ],
    );
  }
}
