import 'package:ddara/core/designsystem/theme/app_colors.dart';
import 'package:ddara/core/designsystem/theme/app_typography.dart';
import 'package:flutter/widgets.dart';

/// 화면/섹션 제목 텍스트. ([AppTypography.headlineLarge])
///
/// 정렬은 사용처마다 다를 수 있어 [textAlign] 으로 받는다.
class AppTitle extends StatelessWidget {
  const AppTitle(this.text, {super.key, this.textAlign});

  final String text;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: AppTypography.headlineLarge.copyWith(color: AppColors.textPrimary),
    );
  }
}
