import 'package:flutter/material.dart';

/// 온보딩 각 페이지 하단의 설명 문구. 내용(text)만 바꿔 모든 페이지에서 재사용한다.
class OnboardingDescription extends StatelessWidget {
  const OnboardingDescription(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color(0xFFA2A2A4),
        fontSize: 14,
        fontFamily: 'Noto Sans KR',
        fontWeight: FontWeight.w400,
        height: 1.60,
        letterSpacing: -0.14,
      ),
    );
  }
}
