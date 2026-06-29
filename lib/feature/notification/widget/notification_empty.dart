import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:flutter/widgets.dart';

/// 알림이 하나도 없을 때 보여주는 빈 상태 화면.
class NotificationEmpty extends StatelessWidget {
  const NotificationEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AppText.headlineLarge(
          '새로운 알림이 없어요',
          textAlign: TextAlign.center,
        ),
        const AppText.body(
          '알림을 받으면 여기에 표시돼요',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.s3),
        Image.asset(
          'assets/images/empty_notification.png',
          width: 160,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
