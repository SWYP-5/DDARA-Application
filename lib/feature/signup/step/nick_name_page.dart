import 'package:ddara/core/designsystem/theme/app_colors.dart';
import 'package:ddara/core/designsystem/component/app_button.dart';
import 'package:ddara/core/widget/app_description.dart';
import 'package:ddara/core/widget/app_title.dart';
import 'package:flutter/cupertino.dart';

class NicknamePage extends StatelessWidget {
  final ValueChanged<String> onChanged;

  final VoidCallback onSignUpButtonClicked;

  const NicknamePage({
    super.key,
    required this.onChanged,
    required this.onSignUpButtonClicked,
  });

  static const _hintStyle = TextStyle(
    color: AppColors.textTertiary,
    fontSize: 14,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 1.55,
    letterSpacing: -0.14,
  );

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
                  AppTitle('어떻게 불러드릴까요?'),
                  AppDescription('친구들에게 보여질 이름이에요'),
                ],
              ),

              // 닉네임 입력 필드
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
                  onChanged: onChanged,
                  maxLength: 10,
                  textInputAction: TextInputAction.done,
                  padding: EdgeInsets.zero,
                  decoration: null,
                  placeholder: '닉네임 (2~10자)',
                  placeholderStyle: _hintStyle,
                  style: _hintStyle.copyWith(color: AppColors.textPrimary),
                  cursorColor: AppColors.accentDefault,
                ),
              ),
            ],
          ),

          const Spacer(),

          AppButton(
            label: '시작하기',
            onPressed: onSignUpButtonClicked,
          ),
        ],
      ),
    );
  }
}
