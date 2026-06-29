import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:flutter/material.dart';

/// 온보딩 3페이지의 스와이프 콘텐츠 (제목 + 설명).
///
/// 로고·인디케이터는 [OnboardingPage] 가 고정으로 들고 있고,
/// 이 위젯만 PageView 안에서 좌우로 전환된다.
class OnboardingThirdPage extends StatelessWidget {
  const OnboardingThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppSpacing.s3,
      children: [
        AppText.headlineLarge('아는 친구끼리만, 초대로만', textAlign: TextAlign.center),
        AppText.body(
          '초대받은 친구만 들어올 수 있어요',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
