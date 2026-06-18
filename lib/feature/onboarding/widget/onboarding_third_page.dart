import 'package:ddara/core/widget/app_title.dart';
import 'package:ddara/feature/onboarding/widget/onboarding_brand.dart';
import 'package:ddara/feature/onboarding/widget/onboarding_description.dart';
import 'package:ddara/feature/onboarding/widget/onboarding_page_indicator.dart';
import 'package:flutter/material.dart';

class OnboardingThirdPage extends StatelessWidget {
  const OnboardingThirdPage({super.key});

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
          const AppTitle('아는 친구끼리만, 초대로만', textAlign: TextAlign.center),
          const OnboardingDescription(
            '초대 링크를 받은 친구만 들어올 수 있어요.\n모르는 사람 없이, 우리끼리 편하게.',
          ),
          const OnboardingPageIndicator(currentIndex: 2),
        ],
      ),
    );
  }
}
