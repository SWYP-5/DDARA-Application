import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:flutter/material.dart';

/// 온보딩 2페이지의 스와이프 콘텐츠 (제목 + 설명).
///
/// 로고·인디케이터는 [OnboardingPage] 가 고정으로 들고 있고,
/// 이 위젯만 PageView 안에서 좌우로 전환된다.
class OnboardingSecondPage extends StatelessWidget {
  const OnboardingSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppSpacing.s3,
      children: [
        AppText.headlineLarge('제일 비슷하게 찍은 친구가 우승', textAlign: TextAlign.center),
        AppText.body(
          '인증샷이 끝나면\n베스트 따라쟁이를 투표해요.\n우승한 친구가 다음 인증샷을 열어요.',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
