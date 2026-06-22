import 'package:ddara/core/designsystem/component/app_button.dart';
import 'package:ddara/core/designsystem/theme/app_colors.dart';
import 'package:ddara/core/widget/app_description.dart';
import 'package:ddara/core/widget/app_title.dart';
import 'package:ddara/feature/signup/step/util/birthday_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../core/designsystem/theme/app_typography.dart';

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

class _BirthPageState extends State<BirthPage> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialValue,
  );

  static final _hintStyle = AppTypography.body.copyWith(
    color: AppColors.textTertiary,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

              // 생년월일 입력 필드
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: AppColors.bgSurface,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 1,
                      color: AppColors.borderDefault,
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
            ],
          ),

          const Spacer(),

          // 하단 버튼
          AppButton(label: '다음', onPressed: widget.onNextButtonClicked),
        ],
      ),
    );
  }
}
