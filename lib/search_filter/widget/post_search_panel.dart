import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/search_filter/search_filter.dart';

class PostSearchPanel extends StatefulWidget {
  const PostSearchPanel({
    super.key,
  });

  @override
  State<PostSearchPanel> createState() => _PostSearchPanelState();
}

class _PostSearchPanelState extends State<PostSearchPanel> {
  late TextEditingController _searchController;
  late bool _isValueEmpty;

  @override
  void initState() {
    super.initState();
    _isValueEmpty = true;
    _searchController = TextEditingController()
      ..addListener(() {
        setState(() {
          _isValueEmpty = _searchController.text.isEmpty;
        });
      });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Tìm theo quận, tên đường, địa điểm',
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          suffixIcon: !_isValueEmpty
              ? IconButton(
                  icon: Assets.icons.close
                      .svg(color: Theme.of(context).colorScheme.onSurface),
                  onPressed: () {
                    _searchController.clear();
                    context
                        .read<SearchFilterBloc>()
                        .add(SearchChanged(_searchController.text));
                  },
                )
              : null,
        ),
        onChanged: (_) => EasyDebounce.debounce(
          'search filter',
          const Duration(milliseconds: 300),
          () => context
              .read<SearchFilterBloc>()
              .add(SearchChanged(_searchController.text)),
        ),
      ),
    );
  }
}
