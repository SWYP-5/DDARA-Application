import 'package:ddara/core/designsystem/theme/app_colors.dart';
import 'package:flutter/widgets.dart';

class AppDescription extends StatelessWidget {
  const AppDescription(this.text, {super.key, this.textAlign});

  final String text;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 14,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w400,
        height: 1.55,
        letterSpacing: -0.14,
      ),
    );
  }
}
