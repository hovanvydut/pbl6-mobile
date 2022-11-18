import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:pbl6_mobile/post/post.dart';

class BookmarkIconButton extends StatelessWidget {
  const BookmarkIconButton({
    super.key,
    this.isBookmarked = false,
    this.backgroundTransprent = false,
    required this.onBookmarkedPressed,
    required this.onUnBookmarkedPressed,
  });

  final bool isBookmarked;
  final bool backgroundTransprent;
  final VoidCallback onBookmarkedPressed;
  final VoidCallback onUnBookmarkedPressed;

  @override
  Widget build(BuildContext context) {
    if (context.watch<AuthenticationBloc>().state.user == null) {
      return const SizedBox();
    }
    
    if (isBookmarked) {
      return Padding(
        padding: const EdgeInsets.all(4),
        child: CircleAvatar(
          backgroundColor: backgroundTransprent
              ? Colors.transparent
              : Theme.of(context).colorScheme.surface.withOpacity(0.6),
          child: IconButton(
            icon: Assets.icons.bookmarkBold.svg(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: onBookmarkedPressed.call,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(4),
        child: CircleAvatar(
          backgroundColor: backgroundTransprent
              ? Colors.transparent
              : Theme.of(context).colorScheme.surface.withOpacity(0.6),
          child: IconButton(
            icon: Assets.icons.bookmarkOutline.svg(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: onUnBookmarkedPressed.call,
          ),
        ),
      );
    }
  }
}
