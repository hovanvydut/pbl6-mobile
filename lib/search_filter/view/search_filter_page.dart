import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pbl6_mobile/search_filter/search_filter.dart';

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
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('SearchFilterView is working'),
      ),
    );
  }
}
