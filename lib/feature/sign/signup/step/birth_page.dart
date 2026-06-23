import 'package:ddara/core/designsystem/component/app_button.dart';
import 'package:ddara/core/designsystem/theme/app_colors.dart';
import 'package:ddara/core/widget/app_description.dart';
import 'package:ddara/core/widget/app_title.dart';
import 'package:ddara/feature/sign/signup/step/util/birthday_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../../core/designsystem/theme/app_typography.dart';

class BirthPage extends StatefulWidget {
  /// 뒤로가기로 다시 들어왔을 때 복원할 기존 입력값.
  final String initialValue;
  final ValueChanged<String> onChanged;
  final VoidCallback onNextButtonClicked;

  const BirthPage({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.onNextButtonClicked,
  });

  @override
  State<BirthPage> createState() => _BirthPageState();
}

/// 생년월일 입력 검증 결과.
enum _BirthStatus {
  /// 8자리를 아직 다 채우지 못함. (안내 문구 없음)
  incomplete,

  /// 8자리를 채웠으나 존재하지 않는 날짜 또는 미래 날짜.
  invalidDate,

  /// 형식은 올바르나 만 14세 미만.
  underage,

  /// 만 14세 이상 — 가입 가능.
  valid,
}

class _BirthPageState extends State<BirthPage> {
  /// 가입 가능 최소 나이.
  static const _minAge = 14;

  late final TextEditingController _controller = TextEditingController(
    text: widget.initialValue,
  )..addListener(_onTextChanged);

  static final _hintStyle = AppTypography.body.copyWith(
    color: AppColors.textTertiary,
  );

  void _onTextChanged() => setState(() {});

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  /// 현재 입력값을 검증한 상태.
  _BirthStatus get _status {
    final digits = _controller.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length < 8) return _BirthStatus.incomplete;

    final date = _tryParseDate(digits);
    if (date == null) return _BirthStatus.invalidDate;

    return _ageInYears(date) >= _minAge
        ? _BirthStatus.valid
        : _BirthStatus.underage;
  }

  /// `YYYYMMDD` 8자리를 실제 존재하는 과거 날짜로 파싱. 유효하지 않으면 null.
  DateTime? _tryParseDate(String digits) {
    final year = int.parse(digits.substring(0, 4));
    final month = int.parse(digits.substring(4, 6));
    final day = int.parse(digits.substring(6, 8));

    final date = DateTime(year, month, day);
    // DateTime 은 2008-02-31 같은 값을 다음 달로 넘겨버리므로 역검증한다.
    final isRealDate =
        date.year == year && date.month == month && date.day == day;
    if (!isRealDate) return null;
    // 미래 날짜는 무효.
    if (date.isAfter(DateTime.now())) return null;

    return date;
  }

  /// 오늘 기준 만 나이.
  int _ageInYears(DateTime birth) {
    final now = DateTime.now();
    var age = now.year - birth.year;
    final hasNotHadBirthdayThisYear =
        now.month < birth.month ||
        (now.month == birth.month && now.day < birth.day);
    if (hasNotHadBirthdayThisYear) age--;
    return age;
  }

  @override
  Widget build(BuildContext context) {
    final status = _status;
    // 입력을 다 채운 뒤에만 노출되는 안내 문구. (미입력 단계에선 null)
    final errorMessage = switch (status) {
      _BirthStatus.invalidDate => '올바르지 않은 생년월일입니다.',
      _BirthStatus.underage => '만 $_minAge세 이상만 가입할 수 있습니다.',
      _BirthStatus.incomplete || _BirthStatus.valid => null,
    };

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 16),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 콘텐츠
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24,
            children: [
              // 헤더
              const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  AppTitle('생년월일을 알려주세요'),
                  AppDescription('만 14세 이상부터 가입할 수 있어요'),
                ],
              ),

              // 생년월일 입력 필드 + 검증 안내
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      color: AppColors.bgSurface,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: errorMessage != null
                              ? AppColors.statusDanger
                              : AppColors.borderDefault,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: CupertinoTextField(
                      controller: _controller,
                      onChanged: widget.onChanged,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        BirthdayInputFormatter(),
                      ],
                      padding: EdgeInsets.zero,
                      decoration: null,
                      placeholder: '예) 2008 . 01 . 01',
                      placeholderStyle: _hintStyle,
                      style: _hintStyle.copyWith(color: AppColors.textPrimary),
                      cursorColor: AppColors.accentDefault,
                    ),
                  ),

                  // 입력 완료 후 검증 실패 시 노출되는 에러 문구.
                  if (errorMessage != null)
                    Text(
                      errorMessage,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.statusDanger,
                      ),
                    ),
                ],
              ),
            ],
          ),

          const Spacer(),

          // 하단 버튼 (만 14세 이상 유효 입력 시에만 활성화)
          AppButton(
            label: '다음',
            onPressed: status == _BirthStatus.valid
                ? widget.onNextButtonClicked
                : null,
          ),
        ],
      ),
    );
  }
}
