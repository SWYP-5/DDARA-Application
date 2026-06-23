import 'package:ddara/core/designsystem/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 지난 따라찍기 - 날짜 선택 카드.
class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.s3),
      decoration: ShapeDecoration(
        color: AppColors.bgSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppSpacing.s1,
        children: [
          Text(
            '선택한 날짜',
            style: AppTypography.body.copyWith(color: AppColors.textPrimary),
          ),
          SvgPicture.asset('assets/images/ic_calendar.svg'),
        ],
      ),
    );
  }
}
