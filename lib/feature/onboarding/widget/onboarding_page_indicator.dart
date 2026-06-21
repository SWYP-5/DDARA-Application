import 'package:flutter/material.dart';

/// 온보딩 페이지 인디케이터. 현재 페이지(currentIndex)의 점만 길게 표시한다.
class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    super.key,
    required this.currentIndex,
    this.count = 3,
  });

  /// 현재 활성화된 페이지 인덱스 (0부터 시작).
  final int currentIndex;

  /// 전체 페이지 수.
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 6,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return Container(
          width: isActive ? 20 : 6,
          height: 6,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: isActive ? Colors.white : const Color(0xFF8A8B8D),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        );
      }),
    );
  }
}
