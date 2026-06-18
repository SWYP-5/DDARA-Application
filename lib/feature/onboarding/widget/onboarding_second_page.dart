import 'package:ddara/core/widget/app_description.dart';
import 'package:ddara/core/widget/app_title.dart';
import 'package:ddara/feature/onboarding/widget/onboarding_brand.dart';
import 'package:ddara/feature/onboarding/widget/onboarding_page_indicator.dart';
import 'package:flutter/material.dart';

class OnboardingSecondPage extends StatelessWidget {
  const OnboardingSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 40),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 14,
        children: [
          const OnboardingBrand(),
          const SizedBox(width: 1, height: 60),
          const AppTitle('제일 비슷하게 찍은 친구가 우승', textAlign: TextAlign.center),
          const AppDescription(
            '인증샷이 끝나면\n베스트 따라쟁이를 투표해요.\n우승한 친구가 다음 인증샷을 열어요.',
            textAlign: TextAlign.center,
          ),
          const OnboardingPageIndicator(currentIndex: 1),
        ],
      ),
    );
  }
}
