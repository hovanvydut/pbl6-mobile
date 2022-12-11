import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/notification/notification.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
  });

  final NotificationData notification;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: notification.hasRead ? 16 : 16,
            top: 8,
            bottom: 8,
          ),
          child: Row(
            children: [
              Column(
                children: [
                  _buildNotificationType(context),
                  const SizedBox(height: 16),
                  _buildUserAvatar(),
                ],
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _overallTitle,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildNotificationMessage(context),
                    const SizedBox(height: 8),
                    Text(
                      '${notification.createdAt.toLocal().yMdHm} '
                      '- ${notification.createdAt.toLocal().timeAgo}',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onBackground,
                      ),
                    )
                  ],
                ),
              ),
              if (!notification.hasRead) ...[
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: context.colorScheme.surfaceVariant,
                  child: IconButton(
                    icon: Assets.icons.checkCheck
                        .svg(color: context.colorScheme.onSurfaceVariant),
                    onPressed: () => context
                        .read<NotificationBloc>()
                        .add(ReadNotification(notificiation: notification)),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationMessage(BuildContext context) {
    switch (notification.code) {
      case NotificationType.hostConfirmMet:
        return Text.rich(
          TextSpan(
            text: notification.username,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onBackground,
              fontWeight: FontWeight.w700,
            ),
            children: [
              TextSpan(
                text: ' đã xác nhận bạn đã đên xem trọ ',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onBackground,
                ),
              ),
              TextSpan(
                text: notification.extraData.postTitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onBackground,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      case NotificationType.hostApproveMeeting:
        return Text.rich(
          TextSpan(
            text: notification.username,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onBackground,
              fontWeight: FontWeight.w700,
            ),
            children: [
              TextSpan(
                text: ' đã xác nhận lịch xem trọ của bạn',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onBackground,
                ),
              ),
            ],
          ),
        );
      case NotificationType.hasBookingOnPost:
        return Text.rich(
          TextSpan(
            text: notification.username,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onBackground,
              fontWeight: FontWeight.w700,
            ),
            children: [
              TextSpan(
                text: ' hẹn xem trọ ',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onBackground,
                ),
              ),
              TextSpan(
                text: notification.extraData.postTitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onBackground,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      case NotificationType.hasReviewOnPost:
        return Text.rich(
          TextSpan(
            text: notification.username,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onBackground,
              fontWeight: FontWeight.w700,
            ),
            children: [
              TextSpan(
                text: ' đánh giá: '
                    '${notification.extraData.reviewContent ?? ''} '
                    'về bài viết ',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onBackground,
                ),
              ),
              TextSpan(
                text: notification.extraData.postTitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onBackground,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
    }
  }

  Widget _buildUserAvatar() {
    return CachedNetworkImage(
      imageUrl: notification.avatarUrl,
      imageBuilder: (context, imageProvider) => GestureDetector(
        onTap: () => context.pushToViewImage(
          notification.avatarUrl,
        ),
        child: CircleAvatar(
          radius: 24,
          backgroundImage: imageProvider,
        ),
      ),
      placeholder: (context, url) => CircleAvatar(
        radius: 24,
        backgroundColor: context.colorScheme.surface,
        child: const CircularProgressIndicator(
          strokeWidth: 2.5,
        ),
      ),
      errorWidget: (context, url, error) => CircleAvatar(
        radius: 24,
        backgroundColor: context.colorScheme.surface,
        child: Assets.icons.danger.svg(color: context.colorScheme.onSurface),
      ),
    );
  }

  String get _overallTitle {
    switch (notification.code) {
      case NotificationType.hostConfirmMet:
        return 'Chủ trọ xác nhận bạn đã đến xem trọ';
      case NotificationType.hostApproveMeeting:
        return 'Chủ trọ xác nhận lịch xem trọ';
      case NotificationType.hasBookingOnPost:
        return 'Bạn có lịch hẹn xem trọ mới';
      case NotificationType.hasReviewOnPost:
        return 'Bạn có một đánh giá mới';
    }
  }

  Widget _buildNotificationType(BuildContext context) {
    SvgGenImage image;
    Color color;
    switch (notification.code) {
      case NotificationType.hostConfirmMet:
        image = Assets.icons.calendarCheck;
        color = Colors.green.withOpacity(0.7);
        break;
      case NotificationType.hostApproveMeeting:
        image = Assets.icons.userCheck;
        color = Colors.blue.withOpacity(0.7);
        break;
      case NotificationType.hasBookingOnPost:
        image = Assets.icons.calendarClock;
        color = context.colorScheme.error.withOpacity(0.7);

        break;

      case NotificationType.hasReviewOnPost:
        image = Assets.icons.starOutline;
        color = Colors.yellow.withOpacity(0.7);
        break;
    }
    return CircleAvatar(
      radius: 18,
      backgroundColor: color,
      child: image.svg(
        height: 20,
        color: Colors.white,
      ),
    );
  }
}
