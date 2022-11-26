import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/upload_post/upload_post.dart';
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
    final uploadPostBlog = context.read<UploadPostBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Thông tin thêm',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        box16,
        AppTextField(
          labelText: 'Số người tối đã',
          keyboardType: TextInputType.number,
          onChanged: (maxOfPerson) =>
              uploadPostBlog.add(MaxOfPersonChanged(maxOfPerson)),
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
              labelText: 'Tiền cọc',
              keyboardType: TextInputType.number,
              inputFormatters: [formatter],
              onChanged: (_) => uploadPostBlog.add(
                DipositChanged(formatter.getUnformattedValue()),
              ),
              lastField: true,
            );
          },
        ),
        box24,
        BlocBuilder<UploadPostBloc, UploadPostState>(
          builder: (context, state) {
            return AppDropDownMuliSelectField(
              labelText: 'Tiện ích khác',
              options: state.otherUtilsData
                  .map<String>((util) => util.displayName)
                  .toList(),
              selectedItems: state.selectedOtherUtils,
              onChanged: (utils) =>
                  uploadPostBlog.add(OtherUtilitiesSelected(utils)),
            );
          },
        ),
        box24,
        BlocBuilder<UploadPostBloc, UploadPostState>(
          buildWhen: (previous, current) =>
              previous.selectedRentailObjects !=
                  current.selectedRentailObjects ||
              previous.rentalObjectsData != current.rentalObjectsData,
          builder: (context, state) {
            return AppDropDownMuliSelectField(
              labelText: 'Đối tượng cho thuê',
              options: state.rentalObjectsData
                  .map<String>((objects) => objects.displayName)
                  .toList(),
              selectedItems: state.selectedRentailObjects,
              onChanged: (objects) =>
                  uploadPostBlog.add(RentalObjectsSelected(objects)),
            );
          },
        ),
        box24,
        BlocBuilder<UploadPostBloc, UploadPostState>(
          // buildWhen: (previous, current) =>
          //     previous.selectedNearbyPlaces != current.selectedNearbyPlaces,
          builder: (context, state) {
            return AppDropDownMuliSelectField(
              labelText: 'Địa điểm gần đó',
              options: state.nearbyPlacesData
                  .map<String>((places) => places.displayName)
                  .toList(),
              selectedItems: state.selectedNearbyPlaces,
              onChanged: (places) =>
                  uploadPostBlog.add(NearbyPlacesSelected(places)),
            );
          },
        ),
      ],
    );
  }
}
