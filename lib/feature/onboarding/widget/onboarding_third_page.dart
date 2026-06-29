import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// 온보딩 3페이지의 스와이프 콘텐츠 (제목 + 설명).
///
/// 로고·인디케이터는 [OnboardingPage] 가 고정으로 들고 있고,
/// 이 위젯만 PageView 안에서 좌우로 전환된다.
class OnboardingThirdPage extends StatelessWidget {
  const OnboardingThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppSpacing.s3,
      children: [
        AppText.headlineLarge(
          l10n.onboardingThirdTitle,
          textAlign: TextAlign.center,
        ),
        AppText.body(l10n.onboardingThirdBody, textAlign: TextAlign.center),
      ],
    );
  }
}
