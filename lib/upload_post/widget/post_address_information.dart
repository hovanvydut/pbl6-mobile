import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/upload_post/upload_post.dart';
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
        BlocBuilder<UploadPostBloc, UploadPostState>(
          builder: (context, state) {
            return AppDropDownField<String>(
              labelText: 'Tỉnh/Thành phố',
              items: state.provincesData
                  .map<DropdownMenuItem<String>>(
                    (province) => DropdownMenuItem(
                      value: province.id.toString(),
                      child: Text(province.name),
                    ),
                  )
                  .toList(),
              onChanged: (province) {
                if (province != null) {
                  context
                      .read<UploadPostBloc>()
                      .add(ProvinceSelected(province));
                }
              },
            );
          },
        ),
        box24,
        BlocBuilder<UploadPostBloc, UploadPostState>(
          builder: (context, state) {
            return AppDropDownField<String>(
              labelText: 'Quận/Huyện',
              value: state.selectedDistrict == 0
                  ? null
                  : state.selectedDistrict.toString(),
              items: state.districtsData
                  .map<DropdownMenuItem<String>>(
                    (district) => DropdownMenuItem(
                      value: district.id.toString(),
                      child: Text(district.name),
                    ),
                  )
                  .toList(),
              onChanged: (district) {
                if (district != null) {
                  context
                      .read<UploadPostBloc>()
                      .add(DistrictSelected(district));
                }
              },
            );
          },
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
