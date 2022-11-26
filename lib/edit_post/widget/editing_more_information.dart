import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/edit_post/edit_post.dart';
import 'package:widgets/widgets.dart';

class EditingMoreInformation extends StatelessWidget {
  const EditingMoreInformation({
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
    final editPostBloc = context.read<EditPostBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Thông tin thêm',
          style: context.textTheme.titleLarge,
        ),
        box16,
        AppTextField(
          labelText: 'Số người tối đã',
          initialValue: post.limitTenant.toString(),
          keyboardType: TextInputType.number,
          onChanged: (limit) => editPostBloc.add(MaxOfPersonChanged(limit)),
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
              initialValue: formatter.format(post.prePaidPrice.toString()),
              labelText: 'Tiền cọc',
              keyboardType: TextInputType.number,
              inputFormatters: [formatter],
              onChanged: (_) => editPostBloc
                  .add(DipositChanged(formatter.getUnformattedValue())),
            );
          },
        ),
        box24,
        BlocBuilder<EditPostBloc, EditPostState>(
          builder: (context, state) {
            return AppDropDownMuliSelectField(
              labelText: 'Tiện ích khác',
              options: state.otherUtilsData
                  .map<String>((util) => util.displayName)
                  .toList(),
              selectedItems: state.selectedOtherUtils,
              onChanged: (utils) =>
                  editPostBloc.add(OtherUtilitiesSelected(utils)),
            );
          },
        ),
        box24,
        BlocBuilder<EditPostBloc, EditPostState>(
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
                  editPostBloc.add(RentalObjectsSelected(objects)),
            );
          },
        ),
        box24,
        BlocBuilder<EditPostBloc, EditPostState>(
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
                  editPostBloc.add(NearbyPlacesSelected(places)),
            );
          },
        ),
      ],
    );
  }
}
