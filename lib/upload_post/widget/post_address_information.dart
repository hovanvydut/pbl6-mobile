import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
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
    final uploadPostBlog = context.read<UploadPostBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Địa chỉ',
          style: context.textTheme.titleLarge,
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
                  uploadPostBlog.add(ProvinceSelected(province));
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
                  uploadPostBlog.add(DistrictSelected(district));
                }
              },
            );
          },
        ),
        box24,
        BlocBuilder<UploadPostBloc, UploadPostState>(
          builder: (context, state) {
            return AppDropDownField<String>(
              labelText: 'Phường/Xã',
              value: state.selectedWard == 0
                  ? null
                  : state.selectedWard.toString(),
              items: state.wardsData
                  .map<DropdownMenuItem<String>>(
                    (ward) => DropdownMenuItem(
                      value: ward.id.toString(),
                      child: Text(ward.name),
                    ),
                  )
                  .toList(),
              onChanged: (ward) {
                if (ward != null) {
                  context.read<UploadPostBloc>().add(WardSelected(ward));
                }
              },
            );
          },
        ),
        box24,
        AppTextField(
          labelText: 'Địa chỉ cụ thể',
          onChanged: (address) =>
              uploadPostBlog.add(DetailAddressChanged(address)),
        ),
      ],
    );
  }
}
