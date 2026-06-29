import 'package:ddara/core/designsystem/component/app_text_field.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/widget/title_description.dart';
import 'package:flutter/widgets.dart';

/// 모임에서 사용할 닉네임을 입력받는 폼.
///
/// "[groupName] 안에서 어떻게 불러드릴까요?" 제목 아래 닉네임 입력 필드와
/// 안내 문구를 보여준다. 입력값은 [onChanged] 로 부모에 전달하고, 검증 에러는
/// [errorText] 로 표시한다. (입력 컨트롤러는 내부에서 소유한다)
class SetNickname extends StatefulWidget {
  const SetNickname({
    super.key,
    required this.groupName,
    this.onChanged,
    this.errorText,
  });

  /// 닉네임을 정할 대상 모임 이름. (제목에 노출)
  final String groupName;

  /// 입력값이 바뀔 때 호출.
  final ValueChanged<String>? onChanged;

  /// 입력 박스 아래에 표시할 에러 문구. null 이면 에러 없음.
  final String? errorText;

  @override
  State<SetNickname> createState() => _SetNicknameState();
}

class _SetNicknameState extends State<SetNickname> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      // 바깥 간격 s2 → 입력 필드와 caption 사이가 s2.
      spacing: AppSpacing.s2,
      children: [
        TitleDescription(
          title: '${widget.groupName} 안에서\n어떻게 불러드릴까요?',
          description: '친구들에게 보이는 이름이에요',
        ),
        // body 다음 간격 s6. (바깥 spacing s2 가 SizedBox 양옆에 붙으므로 s2+s2+s2=s6)
        const SizedBox(height: AppSpacing.s2),
        AppTextField(
          placeholder: '닉네임 (2~10자)',
          controller: _controller,
          highlightWhenFilled: true,
          errorText: widget.errorText,
          onChanged: widget.onChanged,
        ),
        const AppText.caption(
          '*한글과 영어만 사용 가능해요\n'
          '**욕설·혐오·사칭 등 부적절한 닉네임은 변경될 수 있어요(자세한 기준 → 운영정책)',
        ),
      ],
    );
  }
}
