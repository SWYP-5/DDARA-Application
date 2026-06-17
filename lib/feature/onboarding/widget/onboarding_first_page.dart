import 'package:ddara/feature/onboarding/widget/onboarding_brand.dart';
import 'package:ddara/feature/onboarding/widget/onboarding_description.dart';
import 'package:ddara/feature/onboarding/widget/onboarding_page_indicator.dart';
import 'package:ddara/feature/onboarding/widget/onboarding_title.dart';
import 'package:flutter/material.dart';

class OnboardingFirstPage extends StatelessWidget {
  const OnboardingFirstPage({super.key});

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
          const OnboardingTitle('한 장 찍으면 인증샷이 시작돼'),
          const OnboardingDescription(
            '내가 찍은 포즈를 친구가 따라 찍고,\n다음 친구에게 넘어가요.\n우리만의 앨범이 차곡차곡 쌓여요.',
          ),
          const OnboardingPageIndicator(currentIndex: 0),
        ],
      ),
    );
  }
}
