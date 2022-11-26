import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/upload_post/upload_post.dart';
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
    final uploadPostBlog = context.read<UploadPostBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Thông tin chi tiết',
          style: context.textTheme.titleLarge,
        ),
        box16,
        BlocBuilder<UploadPostBloc, UploadPostState>(
          builder: (context, state) {
            return AppDropDownField<String>(
              value: state.selectedHouseType == 0
                  ? null
                  : state.selectedHouseType.toString(),
              labelText: 'Loại phòng',
              items: state.houseTypesData
                  .map<DropdownMenuItem<String>>(
                    (type) => DropdownMenuItem<String>(
                      value: type.id.toString(),
                      child: Text(type.name),
                    ),
                  )
                  .toList(),
              onChanged: (houseType) {
                if (houseType != null) {
                  uploadPostBlog.add(HouseTypeSelected(houseType));
                }
              },
            );
          },
        ),
        box24,
        Builder(
          builder: (context) {
            final formatter = CurrencyTextInputFormatter(
              locale: 'vi',
              symbol: 'VND',
              decimalDigits: 0,
            );
            return AppTextField(
              labelText: 'Giá',
              inputFormatters: [formatter],
              onChanged: (_) => uploadPostBlog
                  .add(RoomPriceChanged(formatter.getUnformattedValue())),
              keyboardType: TextInputType.number,
            );
          },
        ),
        box24,
        AppTextField(
          labelText: 'Diện tích',
          onChanged: (area) => uploadPostBlog.add(RoomAreaChanged(area)),
          keyboardType: TextInputType.number,
        )
      ],
    );
  }
}
