import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/edit_post/edit_post.dart';
import 'package:widgets/widgets.dart';

class EditingAddressInformation extends StatelessWidget {
  const EditingAddressInformation({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    const box16 = SizedBox(
      height: 16,
    );
    const box24 = SizedBox(
      height: 24,
    );
    final editUserPostBloc = context.read<EditUserPostBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Địa chỉ',
          style: context.textTheme.titleLarge,
        ),
        box16,
        BlocBuilder<EditUserPostBloc, EditUserPostState>(
          builder: (context, state) {
            return AppDropDownField<String>(
              labelText: 'Tỉnh/Thành phố',
              value: post.fullAddress.province.id.toString(),
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
                  editUserPostBloc.add(ProvinceSelected(province));
                }
              },
            );
          },
        ),
        box24,
        BlocBuilder<EditUserPostBloc, EditUserPostState>(
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
                  editUserPostBloc.add(DistrictSelected(district));
                }
              },
            );
          },
        ),
        box24,
        BlocBuilder<EditUserPostBloc, EditUserPostState>(
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
                  editUserPostBloc.add(WardSelected(ward));
                }
              },
            );
          },
        ),
        box24,
        AppTextField(
          initialValue: post.address,
          labelText: 'Địa chỉ cụ thể',
          onChanged: (address) =>
              editUserPostBloc.add(DetailAddressChanged(address)),
        ),
      ],
    );
  }
}
