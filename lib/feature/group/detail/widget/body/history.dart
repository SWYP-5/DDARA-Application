import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/feature/group/detail/widget/body/calendar_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 지난 따라찍기 - 날짜 선택 카드.
class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  /// 선택한 날짜. (아직 고르지 않았으면 null)
  DateTime? _selectedDate;

  /// 달력 다이얼로그를 띄우고, 고른 날짜를 반영한다.
  Future<void> _openCalendar() async {
    final picked = await CalendarDialog.show(context, initialDate: _selectedDate);
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  String get _dateLabel {
    final date = _selectedDate;
    if (date == null) return '선택한 날짜';
    return '${date.year}년 ${date.month}월 ${date.day}일';
  }

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
            _dateLabel,
            style: AppTypography.body.copyWith(color: AppColors.textPrimary),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            onPressed: _openCalendar,
            child: SvgPicture.asset('assets/images/ic_calendar.svg'),
          ),
        ],
      ),
    );
  }
}
