import 'package:flutter/material.dart';

/// 온보딩 전 페이지 상단에 고정으로 표시되는 브랜드 텍스트.
class OnboardingBrand extends StatelessWidget {
  const OnboardingBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'ddara.',
      style: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        height: 1,
        letterSpacing: -0.56,
      ),
    );
  }
}
