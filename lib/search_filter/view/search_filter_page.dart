import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/search_filter/search_filter.dart';
import 'package:widgets/widgets.dart';

class SearchFilterPage extends StatelessWidget {
  const SearchFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchFilterBloc(),
      child: const SearchFilterView(),
    );
  }
}

class SearchFilterView extends StatelessWidget {
  const SearchFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return DissmissKeyboard(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          titleSpacing: 0,
          leading: IconButton(
            icon: Assets.icons.arrorLeft.svg(
              color: theme.colorScheme.onSurface,
              height: 32,
            ),
            onPressed: () => context.pop(),
          ),
          title: const SearchPanel(),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Assets.icons.filterOutline.svg(
                height: 28,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              onPressed: null,
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              Assets.images.searchInitial.svg(height: 200, width: 300),
              const SizedBox(height: 16),
              Text(
                'Kết quả tìm kiếm sẽ hiển thị ở đây',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const Spacer(
                flex: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
