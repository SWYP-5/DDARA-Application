import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/component/app_text_field.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:flutter/cupertino.dart';

class NicknamePage extends StatefulWidget {
  /// 뒤로가기로 다시 들어왔을 때 복원할 기존 입력값.
  final String initialValue;
  final ValueChanged<String> onChanged;
  final VoidCallback onSignUpButtonClicked;

  const NicknamePage({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.onSignUpButtonClicked,
  });

  @override
  State<NicknamePage> createState() => _NicknamePageState();
}

class _NicknamePageState extends State<NicknamePage> {
  /// 가입 가능한 최소 닉네임 길이. (상한은 [CupertinoTextField.maxLength] 가 담당)
  static const _minLength = 2;

  late final TextEditingController _controller = TextEditingController(
    text: widget.initialValue,
  )..addListener(_onTextChanged);

  void _onTextChanged() => setState(() {});

  /// 2자 이상 입력 시에만 가입 가능. (앞뒤 공백은 길이에서 제외)
  bool get _isValid => _controller.text.trim().length >= _minLength;

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
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
                  AppText.headlineLarge('어떻게 불러드릴까요?'),
                  AppText.body('친구들에게 보여질 이름이에요'),
                ],
              ),

              // 닉네임 입력 필드
              AppTextField(
                controller: _controller,
                onChanged: widget.onChanged,
                maxLength: 10,
                textInputAction: TextInputAction.done,
                placeholder: '닉네임 (2~10자)',
              ),
            ],
          ),

          const Spacer(),

          AppButton(
            label: '시작하기',
            onPressed: _isValid ? widget.onSignUpButtonClicked : null,
          ),
        ],
      ),
    );
  }
}
