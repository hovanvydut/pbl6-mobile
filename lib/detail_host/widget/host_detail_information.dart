import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/detail_host/detail_host.dart';

class HostDetailInformation extends StatelessWidget {
  const HostDetailInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Builder(
        builder: (context) {
          final host =
              context.select((DetailHostCubit cubit) => cubit.state.host);
          return Row(
            children: [
              CachedNetworkImage(
                imageUrl: host.avatar ??
                    'https://avatars.githubusercontent.com/u/63831488?v=4',
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 40,
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) => CircleAvatar(
                  radius: 40,
                  backgroundColor: context.colorScheme.surface,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2.5,
                  ),
                ),
                errorWidget: (context, url, error) => CircleAvatar(
                  radius: 40,
                  backgroundColor: context.colorScheme.surface,
                  child: Assets.icons.danger.svg(
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      host.displayName,
                      style: context.textTheme.titleLarge!.copyWith(
                        color: context.colorScheme.onSecondaryContainer,
                      ),
                    ),
                    Text(
                      host.address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
