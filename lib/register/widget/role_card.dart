import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    this.isSelected = false,
    required this.role,
    required this.onTap,
  });

  final bool isSelected;
  final Role role;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: isSelected ? context.colorScheme.primary : null,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              children: [
                Text(
                  title ?? '',
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: isSelected
                        ? context.colorScheme.onPrimary
                        : context.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Bạn có thể đăng bài về trọ, quản lý\n các '
                  'bài đăng, xem thống kê \nvề các bài viết,...',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: isSelected
                        ? context.colorScheme.onPrimary
                        : context.colorScheme.onSurface,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? get title {
    switch (role) {
      case Role.admin:
      case Role.hostAndGuest:
        return null;
      case Role.host:
        return 'Chủ trọ';
      case Role.guest:
        return 'Tìm trọ';
    }
  }

  String? get description {
    switch (role) {
      case Role.host:
        return 'Bạn có thể đăng bài về trọ, quản lý\n các '
            'bài đăng, xem thống kê \nvề các bài viết,...';
      case Role.guest:
        return 'Bạn có thể xem các bài đăng nhà trọ,\n'
            ' lọc theo địa chỉ, các tiện ích, đặt lịch\n'
            ' xem trọ, đánh giá trọ,...';
      case Role.admin:
      case Role.hostAndGuest:
        return null;
    }
  }
}
