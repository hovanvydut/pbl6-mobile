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
        AppDropDownMuliSelectField(
          labelText: 'Tiện ích khác',
          options: const ['Wifi', 'Bla Bla', 'Nhà tắm xịn'],
          selectedItems: const [
            'Wifi',
            'Bla Bla',
            'Nhà tắm xịn',
            'Vip pro',
            'dadad',
            'dqqwd'
          ],
          onChanged: (values) {},
        ),
        box24,
        AppDropDownMuliSelectField(
          labelText: 'Đối tượng cho thuê',
          options: const [
            'Sinh viên',
            'Công nhân',
            'Hehe',
          ],
          selectedItems: const [
            'Sinh viên',
            'Công nhân',
            'Hehe',
          ],
          onChanged: (values) {},
        ),
        box24,
        AppDropDownMuliSelectField(
          labelText: 'Địa điểm gần đó',
          options: const [
            'Trường học',
            'Bệnh viện',
            'Chợ',
            'Công viên',
          ],
          selectedItems: const [
            'Trường học',
            'Bệnh viện',
            'Chợ',
            'Công viên',
          ],
          onChanged: (values) {},
        )
      ],
    );
  }
}
