import 'package:flutter/cupertino.dart';

import '../../../core/designsystem/theme/app_colors.dart';

/// 권한 그룹 구분 라벨. (필수 / 선택)
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w400,
          height: 1.30,
          letterSpacing: -0.12,
        ),
      ),
    );
  }
}
