import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:media/media.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:pbl6_mobile/edit_user_profile/edit_user_profile.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:user/user.dart';
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
      create: (context) => EditUserProfileBloc(
        userRepository: context.read<UserRepository>(),
        mediaRepository: context.read<MediaRepository>(),
      ),
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
    return BlocListener<EditUserProfileBloc, EditUserProfileState>(
      listener: (context, state) {
        if (state.formzStatus == FormzStatus.submissionFailure) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Cập nhật thông tin người dùng thất bại, vui lòng thử lại',
              ),
              duration: Duration(seconds: 2),
            ),
          );
        }
        if (state.formzStatus == FormzStatus.submissionSuccess) {
          ToastHelper.showToast('Đã cập nhật thông tin người dùng');
          context.read<AuthenticationBloc>().add(GetUserInformation());
          context.pop();
        }
      },
      child: DismissFocus(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Assets.icons.arrorLeft.svg(
                color: theme.colorScheme.onSurface,
                height: 32,
              ),
              onPressed: () {
                final editMode =
                    context.read<EditUserProfileBloc>().state.editMode;
                if (editMode) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text('Hủy thay đổi'),
                        content: const Text(
                          'Bạn có muốn hủy thay đổi thông tin cá nhân?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: const Text('Đồng ý'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Hủy'),
                          )
                        ],
                      );
                    },
                  );
                } else {
                  context.pop();
                }
              },
            ),
            title: const Text(
              'Thông tin cá nhân',
            ),
            centerTitle: true,
            actions: const [EditSaveActionButton()],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16) +
                const EdgeInsets.only(top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UserAvatar(user: user),
                const SizedBox(
                  height: 48,
                ),
                UserProfileForm(user: user),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserProfileForm extends StatelessWidget {
  const UserProfileForm({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    const box24 = SizedBox(height: 24);
    return Column(
      children: [
        Builder(
          builder: (context) {
            final editMode = context.select(
              (EditUserProfileBloc bloc) => bloc.state.editMode,
            );

            return AppTextField(
              labelText: 'Tên hiển thị',
              initialValue: user.displayName,
              onChanged: (displayName) => context
                  .read<EditUserProfileBloc>()
                  .add(DisplayNameChanged(displayName)),
              readOnly: !editMode,
            );
          },
        ),
        box24,
        AppTextField(
          labelText: 'Email',
          readOnly: true,
          initialValue: user.userAccountEmail,
        ),
        box24,
        Builder(
          builder: (context) {
            final editMode = context.select(
              (EditUserProfileBloc bloc) => bloc.state.editMode,
            );
            final phoneNumber = context
                .select((EditUserProfileBloc bloc) => bloc.state.phoneNumber);
            return AppTextField(
              labelText: 'Số điện thoại',
              initialValue: user.phoneNumber,
              readOnly: !editMode,
              keyboardType: TextInputType.phone,
              onChanged: (phoneNumber) => context
                  .read<EditUserProfileBloc>()
                  .add(PhoneNumberChanged(phoneNumber)),
            );
          },
        ),
        box24,
        AppTextField(
          labelText: 'Số CMND/CCCD',
          readOnly: true,
          initialValue: user.identityNumber,
        ),
        box24,
        Builder(
          builder: (context) {
            final editMode = context.select(
              (EditUserProfileBloc bloc) => bloc.state.editMode,
            );
            return AppTextField(
              labelText: 'Điạ chỉ',
              initialValue: user.address,
              readOnly: !editMode,
              onChanged: (address) => context
                  .read<EditUserProfileBloc>()
                  .add(AddressChanged(address)),
            );
          },
        ),
      ],
    );
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.user,
  });

  final User user;
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          BlocBuilder<EditUserProfileBloc, EditUserProfileState>(
            builder: (context, state) {
              return state.imagePath.isNotNullOrBlank
                  ? CircleAvatar(
                      radius: 70,
                      backgroundImage: Image.file(File(state.imagePath)).image,
                    )
                  : CachedNetworkImage(
                      imageUrl: user.avatar ??
                          'https://avatars.githubusercontent.com/u/63831488?v=4',
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 70,
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) => CircleAvatar(
                        radius: 40,
                        backgroundColor: theme.colorScheme.surface,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.5,
                        ),
                      ),
                      errorWidget: (context, url, error) => CircleAvatar(
                        radius: 40,
                        backgroundColor: theme.colorScheme.surface,
                        child: Assets.icons.danger
                            .svg(color: theme.colorScheme.onSurface),
                      ),
                    );
            },
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
                    backgroundColor: theme.colorScheme.secondaryContainer,
                    radius: 19,
                    child: Align(
                      child: IconButton(
                        icon: Assets.icons.camera.svg(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                        splashRadius: 24,
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return BlocProvider.value(
                                value: context.read<EditUserProfileBloc>(),
                                child: const ImageActionBottomSheet(),
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
    );
  }
}

class ImageActionBottomSheet extends StatelessWidget {
  const ImageActionBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocListener<EditUserProfileBloc, EditUserProfileState>(
      listenWhen: (previous, current) =>
          previous.imagePath != current.imagePath,
      listener: (context, state) {
        Navigator.of(context).pop();
      },
      child: DecoratedBox(
        decoration: BoxDecoration(color: theme.colorScheme.surface),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Assets.icons.camera.svg(
                  color: theme.colorScheme.onSurface,
                ),
                title: Text(
                  'Chụp ảnh',
                  style: theme.textTheme.titleMedium,
                ),
                onTap: () =>
                    context.read<EditUserProfileBloc>().add(UseCameraPressed()),
              ),
              ListTile(
                leading: Assets.icons.gallery.svg(
                  color: theme.colorScheme.onSurface,
                ),
                title: Text(
                  'Từ thư viện',
                  style: theme.textTheme.titleMedium,
                ),
                onTap: () => context
                    .read<EditUserProfileBloc>()
                    .add(ChooseImagePressed()),
              ),
              BlocBuilder<EditUserProfileBloc, EditUserProfileState>(
                builder: (context, state) {
                  final imagePath = state.imagePath;
                  return imagePath.isNotNullOrEmpty
                      ? ListTile(
                          leading: Assets.icons.close.svg(
                            color: theme.colorScheme.onSurface,
                          ),
                          title: Text(
                            'Xóa ảnh',
                            style: theme.textTheme.titleMedium,
                          ),
                          onTap: () => context.read<EditUserProfileBloc>().add(
                                RemoveImagePressed(),
                              ),
                        )
                      : const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EditSaveActionButton extends StatelessWidget {
  const EditSaveActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Builder(
      builder: (context) {
        final editMode = context.select(
          (EditUserProfileBloc bloc) => bloc.state.editMode,
        );
        return editMode
            ? IconButton(
                icon: Assets.icons.save.svg(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 28,
                ),
                onPressed: () {
                  final user = context.read<AuthenticationBloc>().state.user;
                  context.read<EditUserProfileBloc>().add(EditSubmitted(user!));
                },
              )
            : IconButton(
                icon: Assets.icons.edit.svg(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 28,
                ),
                onPressed: () {
                  final user = context.read<AuthenticationBloc>().state.user;
                  context
                      .read<EditUserProfileBloc>()
                      .add(EditProfilePressed(user!));
                },
              );
      },
    );
  }
}
