import 'package:ddara/core/designsystem/theme/app_colors.dart';
import 'package:ddara/core/designsystem/theme/app_typography.dart';
import 'package:flutter/cupertino.dart';

import '../../foundation/app_radius.dart';



class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;

    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        color: AppColors.accentDefault,
        // 비활성 시 배경색.
        disabledColor: AppColors.bgSurfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.md),
        onPressed: onPressed,
        child: Text(
          label,
          style: AppTypography.title.copyWith(
            color: isEnabled ? AppColors.textOnAccent : AppColors.textDisabled,
          ),
        ),
      ),
    );
  }
}
