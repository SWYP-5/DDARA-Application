import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/component/divider/app_divider.dart';
import 'package:ddara/core/designsystem/component/surface/app_surface.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/widget/app_checkbox.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/widget/title_description.dart';
import 'package:flutter/widgets.dart';

class TermsPage extends StatefulWidget {
  final VoidCallback onNextButtonClicked;

  /// 필수 약관 전체 동의 여부가 바뀔 때 호출. (둘 다 동의해야 true)
  final ValueChanged<bool> onAgreementChanged;

  /// 뒤로가기로 다시 들어왔을 때 복원할 기존 동의 상태.
  final bool initialAgreed;

  const TermsPage({
    super.key,
    required this.onNextButtonClicked,
    required this.onAgreementChanged,
    this.initialAgreed = false,
  });

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  late bool _termsOfService = widget.initialAgreed;
  late bool _privacyPolicy = widget.initialAgreed;

  bool get _allAgreed => _termsOfService && _privacyPolicy;

  void _notify() => widget.onAgreementChanged(_allAgreed);

  void _toggleAll(bool value) {
    setState(() {
      _termsOfService = value;
      _privacyPolicy = value;
    });
    _notify();
  }

  void _toggleTermsOfService(bool value) {
    setState(() => _termsOfService = value);
    _notify();
  }

  void _togglePrivacyPolicy(bool value) {
    setState(() => _privacyPolicy = value);
    _notify();
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
              const TitleDescription(
                title: '약관에 동의해 주세요',
                description: '서비스 이용을 위해선 이용약관 동의가 필요해요',
              ),

              // 동의 목록 카드
              AppSurface(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 전체 동의
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 12,
                        children: [
                          AppCheckbox(
                            value: _allAgreed,
                            onChanged: _toggleAll,
                            size: 22,
                          ),
                          const Expanded(
                            child: AppText.label(
                              '전체 동의',
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 구분선
                    const AppDivider(),

                    // [필수] 이용약관
                    _TermItem(
                      label: '[필수] 이용약관',
                      value: _termsOfService,
                      onChanged: _toggleTermsOfService,
                    ),

                    // [필수] 개인정보 처리방침
                    _TermItem(
                      label: '[필수] 개인정보 처리방침',
                      value: _privacyPolicy,
                      onChanged: _togglePrivacyPolicy,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Spacer(),

          // 하단 버튼 (필수 약관 전체 동의 시에만 활성화)
          AppButton(
            label: '동의하고 계속',
            onPressed: _allAgreed ? widget.onNextButtonClicked : null,
          ),
        ],
      ),
    );
  }
}

/// 개별 필수 약관 항목. (체크박스 · 라벨 · 상세보기 아이콘)
class _TermItem extends StatelessWidget {
  const _TermItem({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          AppCheckbox(value: value, onChanged: onChanged),
          Expanded(child: AppText.body(label)),
          // TODO: 약관 상세보기(>) 아이콘 추후 구현
          const SizedBox(width: 20, height: 20),
        ],
      ),
    );
  }
}
