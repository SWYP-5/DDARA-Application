import 'package:flutter/material.dart';

import '../../../core/designsystem/theme/app_colors.dart';

/// 온보딩 페이지 인디케이터. 현재 페이지(currentIndex)의 점만 길게 표시한다.
///
/// [currentIndex] 가 바뀌면 활성 점의 너비·색이 부드럽게 전환된다.
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
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: isActive ? 20 : 6,
          height: 6,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: isActive ? AppColors.accentDefault : AppColors.textTertiary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        );
      }),
    );
  }
}
