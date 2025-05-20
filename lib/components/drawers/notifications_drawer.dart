import 'package:flutter/material.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';
import 'package:ghiazzi/models/notification_model.dart';

class NotificationsDrawer extends StatelessWidget {
  final List<NotificationModel> notifications;
  final VoidCallback onClose;

  const NotificationsDrawer({
    super.key,
    required this.notifications,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<CustomPalette>()!;
    final appTextStyles =
        Theme.of(context).extension<AppThemeExtension>()!.textStyles;

    // Split notifications into today and this week using createdAt
    final now = DateTime.now();
    bool isToday(NotificationModel n) {
      final created = DateTime.tryParse(n.createdAt);
      if (created == null) return false;
      return created.year == now.year &&
          created.month == now.month &&
          created.day == now.day;
    }

    final today = notifications.where(isToday).toList();
    final thisWeek = notifications.where((n) => !isToday(n)).toList();

    Widget notificationTile(NotificationModel n) {
      Color? titleColor;
      switch (n.category) {
        case NotificationCategory.expiring:
          titleColor = palette.error100;
          break;
        case NotificationCategory.achievement:
          titleColor = palette.success100;
          break;
        default:
          titleColor = palette.primary1000;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  n.title,
                  style: appTextStyles.headingS.copyWith(
                    color: titleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: palette.primary1000,
              ),
            ],
          ),
          if (n.body.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                n.body,
                style: appTextStyles.paragraphS.copyWith(
                  color: palette.grey900,
                ),
              ),
            ),
          const SizedBox(height: 16),
          if (n != notifications.last)
            Divider(height: 1, thickness: 1, color: palette.grey200),
          const SizedBox(height: 16),
        ],
      );
    }

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 500,
        height: double.infinity,
        decoration: BoxDecoration(
          color: palette.grey0,
          boxShadow: [
            BoxShadow(
              color: palette.grey400,
              blurRadius: 16,
              offset: const Offset(-4, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 56.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: onClose,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text('Notifiche', style: appTextStyles.displayM),
                        ],
                      ),
                      const SizedBox(height: 32),
                      if (today.isNotEmpty) ...[
                        Text(
                          'Oggi',
                          style: appTextStyles.headingM.copyWith(
                            color: palette.primary1000,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...today.map(notificationTile),
                      ],
                    ],
                  ),
                ),
                if (thisWeek.isNotEmpty) ...[
                  const SizedBox(height: 40),
                  Divider(height: 1, thickness: 1, color: palette.grey200),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64),
                    child: Column(
                      children: [
                        Text(
                          'Questa settimana',
                          style: appTextStyles.headingM.copyWith(
                            color: palette.primary1000,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...thisWeek.map(notificationTile),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
