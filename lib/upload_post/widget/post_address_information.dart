import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class PostAddressInformation extends StatelessWidget {
  const PostAddressInformation({
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
          'Địa chỉ',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        box16,
        const AppDropDownField<String>(
          labelText: 'Tỉnh/Thành phố',
          items: [
            DropdownMenuItem(
              child: Text('Đà Nẵng'),
            )
          ],
          onChanged: null,
        ),
        box24,
        AppDropDownField<String>(
          labelText: 'Quận/Huyện',
          items: const [
            DropdownMenuItem(
              child: Text('Đà Nẵng'),
            )
          ],
          onChanged: (Object? value) {},
        ),
        box24,
        AppDropDownField<String>(
          labelText: 'Phường/Xã',
          items: const [
            DropdownMenuItem(
              child: Text('Đà Nẵng'),
            )
          ],
          onChanged: (Object? value) {},
        ),
        box24,
        AppTextField(
          labelText: 'Địa chỉ cụ thể',
          onChanged: (Object? value) {},
        ),
      ],
    );
  }
}
