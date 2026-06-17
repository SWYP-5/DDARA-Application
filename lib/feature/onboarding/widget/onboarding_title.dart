import 'package:flutter/material.dart';

/// 온보딩 각 페이지의 제목 문구. 내용(text)만 바꿔 모든 페이지에서 재사용한다.
class OnboardingTitle extends StatelessWidget {
  const OnboardingTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w700,
        height: 1.40,
        letterSpacing: -0.20,
      ),
    );
  }
}
