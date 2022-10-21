import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/edit_user_profile/edit_user_profile.dart';
import 'package:widgets/widgets.dart';

class EditUserProfilePage extends StatelessWidget {
  const EditUserProfilePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditUserProfileBloc>(
      create: (_) => EditUserProfileBloc(),
      child: EditUserProfileView(user: user),
    );
  }
}

class EditUserProfileView extends StatelessWidget {
  const EditUserProfileView({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return DissmissKeyboard(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Assets.icons.arrorLeft.svg(
              color: theme.colorScheme.onSurface,
              height: 32,
            ),
            onPressed: () => context.pop(),
          ),
          title: const Text(
            'Thông tin cá nhân',
          ),
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) {
                final editMode = context
                    .select((EditUserProfileBloc bloc) => bloc.state.editMode);
                return editMode
                    ? IconButton(
                        icon: Assets.icons.save.svg(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 28,
                        ),
                        onPressed: () {},
                      )
                    : IconButton(
                        icon: Assets.icons.edit.svg(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 28,
                        ),
                        onPressed: () => context
                            .read<EditUserProfileBloc>()
                            .add(EditProfilePressed()),
                      );
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16) +
              const EdgeInsets.only(top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: Image.network(
                        'https://avatars.githubusercontent.com/u/63831488?v=4',
                      ).image,
                    ),
                    Builder(
                      builder: (context) {
                        final editMode = context.select(
                          (EditUserProfileBloc bloc) => bloc.state.editMode,
                        );
                        return Visibility(
                          visible: editMode,
                          child: Positioned(
                            child: CircleAvatar(
                              backgroundColor:
                                  theme.colorScheme.secondaryContainer,
                              radius: 19,
                              child: Align(
                                child: IconButton(
                                  icon: Assets.icons.camera.svg(
                                    color:
                                        theme.colorScheme.onSecondaryContainer,
                                  ),
                                  splashRadius: 24,
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (_) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                leading:
                                                    Assets.icons.camera.svg(),
                                                title: Text(
                                                  'Chụp ảnh',
                                                  style: theme
                                                      .textTheme.titleMedium,
                                                ),
                                                onTap: () => context
                                                    .read<EditUserProfileBloc>()
                                                    .add(UseCameraPressed()),
                                              ),
                                              ListTile(
                                                leading:
                                                    Assets.icons.gallery.svg(),
                                                title: Text(
                                                  'Từ thư viện',
                                                  style: theme
                                                      .textTheme.titleMedium,
                                                ),
                                                onTap: () => context
                                                    .read<EditUserProfileBloc>()
                                                    .add(ChooseImagePressed()),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Builder(
                builder: (context) {
                  final editMode = context.select(
                    (EditUserProfileBloc bloc) => bloc.state.editMode,
                  );
                  return AppTextField(
                    labelText: 'Tên hiển thị',
                    initialValue: user.displayName,
                    onChanged: (displayName) {},
                    readOnly: !editMode,
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              AppTextField(
                labelText: 'Email',
                readOnly: true,
                initialValue: user.userAccountEmail,
              ),
              const SizedBox(
                height: 24,
              ),
              Builder(
                builder: (context) {
                  final editMode = context.select(
                    (EditUserProfileBloc bloc) => bloc.state.editMode,
                  );
                  return AppTextField(
                    labelText: 'Số điện thoại',
                    initialValue: user.phoneNumber,
                    readOnly: !editMode,
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              AppTextField(
                labelText: 'Số CMND/CCCD',
                readOnly: true,
                initialValue: user.identityNumber,
              ),
              const SizedBox(
                height: 24,
              ),
              Builder(
                builder: (context) {
                  final editMode = context.select(
                    (EditUserProfileBloc bloc) => bloc.state.editMode,
                  );
                  return AppTextField(
                    labelText: 'Điạ chỉ',
                    initialValue: user.address,
                    readOnly: !editMode,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
