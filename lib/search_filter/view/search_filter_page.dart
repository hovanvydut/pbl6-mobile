import 'package:address/address.dart';
import 'package:category/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/search_filter/search_filter.dart';
import 'package:post/post.dart';
import 'package:property/property.dart';
import 'package:widgets/widgets.dart';

class SearchFilterPage extends StatelessWidget {
  const SearchFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchFilterBloc(
        postRepository: context.read<PostRepository>(),
        addressRepository: context.read<AddressRepository>(),
        categoryRepository: context.read<CategoryRepository>(),
        propertyRepository: context.read<PropertyRepository>(),
      ),
      child: const SearchFilterView(),
    );
  }
}

class SearchFilterView extends StatelessWidget {
  const SearchFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return DismissFocus(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            titleSpacing: 0,
            leading: IconButton(
              icon: Assets.icons.arrorLeft.svg(
                color: theme.colorScheme.onSurface,
                height: 32,
              ),
              onPressed: () => context.pop(),
            ),
            title: SearchField(
              hintText: 'Bạn muốn tìm phòng gì?',
              suffixIcon:
                  Assets.icons.close.svg(color: context.colorScheme.onSurface),
              onChanged: (value) =>
                  context.read<SearchFilterBloc>().add(SearchChanged(value)),
              onSuffixIconPressed: (value) =>
                  context.read<SearchFilterBloc>().add(SearchChanged(value)),
            ),
            centerTitle: true,
            actions: const [SearchFilterActionButton()],
          ),
        ),
        body: const SearchFilterBodyView(),
      ),
    );
  }
}
