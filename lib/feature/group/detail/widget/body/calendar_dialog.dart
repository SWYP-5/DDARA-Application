import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:flutter/cupertino.dart';
// table_calendar 가 내부적으로 Material(InkWell 등)을 요구한다.
import 'package:flutter/material.dart' show Material, MaterialType;
import 'package:table_calendar/table_calendar.dart';

/// 월 그리드 달력 다이얼로그. (가운데 표시 · 다크 테마)
///
/// ```dart
/// final picked = await CalendarDialog.show(context, initialDate: selected);
/// ```
class CalendarDialog extends StatefulWidget {
  const CalendarDialog({super.key, this.initialDate});

  /// 처음 표시할 기준 날짜. (없으면 오늘)
  final DateTime? initialDate;

  /// 달력을 가운데 다이얼로그로 띄우고, 선택한 날짜를 반환한다.
  /// (바깥을 탭해 닫으면 null)
  static Future<DateTime?> show(BuildContext context, {DateTime? initialDate}) {
    return showCupertinoDialog<DateTime>(
      context: context,
      barrierDismissible: true,
      builder: (_) => CalendarDialog(initialDate: initialDate),
    );
  }

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  // 달(5/6주)에 상관없이 높이를 고정하기 위한 명시값.
  static const double _rowHeight = 44;
  static const double _daysOfWeekHeight = 24;
  static const double _headerHeight = 64;
  // 헤더 + 요일줄 + 6주(최대) 기준. 5주 달은 아래에 여백이 생긴다.
  static const double _calendarHeight =
      _headerHeight + _daysOfWeekHeight + _rowHeight * 6;

  late DateTime _focusedDay;
  late DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialDate;
    _focusedDay = widget.initialDate ?? DateTime.now();
  }

  /// 1(월)~7(일) → 한글 요일.
  String _weekdayLabel(int weekday) {
    const labels = ['월', '화', '수', '목', '금', '토', '일'];
    return labels[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s6),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.s3),
            decoration: ShapeDecoration(
              color: AppColors.bgSurface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
            ),
            // 높이를 콘텐츠에 맞춰(위아래 맞춤) 가운데 표시되도록 한다.
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  type: MaterialType.transparency,
                  child: SizedBox(
                    height: _calendarHeight,
                    child: TableCalendar(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.now(),
                      focusedDay: _focusedDay,
                      currentDay: DateTime.now(),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, _) =>
                          Navigator.of(context).pop(selectedDay),
                      onPageChanged: (newFocusedDay) =>
                          setState(() => _focusedDay = newFocusedDay),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        leftChevronIcon: Icon(
                          CupertinoIcons.chevron_left,
                          color: AppColors.textPrimary,
                        ),
                        rightChevronIcon: Icon(
                          CupertinoIcons.chevron_right,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      calendarBuilders: CalendarBuilders(
                        headerTitleBuilder: (context, day) => Center(
                          child: AppText.headlineMedium(
                            '${day.year}년 ${day.month}월',
                          ),
                        ),
                        dowBuilder: (context, day) => Center(
                          child: AppText.caption(_weekdayLabel(day.weekday)),
                        ),
                      ),
                      calendarStyle: CalendarStyle(
                        defaultTextStyle: AppTypography.body.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        weekendTextStyle: AppTypography.body.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        outsideTextStyle: AppTypography.body.copyWith(
                          color: AppColors.textTertiary,
                        ),
                        disabledTextStyle: AppTypography.body.copyWith(
                          color: AppColors.textDisabled,
                        ),
                        todayDecoration: const BoxDecoration(
                          color: AppColors.bgSurfaceAlt,
                          shape: BoxShape.circle,
                        ),
                        todayTextStyle: AppTypography.body.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        selectedDecoration: const BoxDecoration(
                          color: AppColors.accentDefault,
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: AppTypography.body.copyWith(
                          color: AppColors.textOnAccent,
                        ),
                      ),
                      availableGestures: AvailableGestures.horizontalSwipe,
                      rowHeight: _rowHeight,
                      daysOfWeekHeight: _daysOfWeekHeight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
