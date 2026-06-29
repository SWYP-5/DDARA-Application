import 'package:ddara/core/designsystem/component/app_text_field.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/widget/title_description.dart';
import 'package:ddara/feature/group/create/provider/notifier_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 모임 이름·소개를 입력받는 모임 만들기 본문.
///
/// 입력 폼 상태(컨트롤러·검증)만 담당한다. 하단 '다음' 버튼과 생성 결과 처리,
/// 스캐폴드·패딩은 [GroupCreatePage] 가 들고 있다. (버튼은 스텝 간 공유)
class SetGroupName extends ConsumerStatefulWidget {
  const SetGroupName({super.key});

  @override
  ConsumerState<SetGroupName> createState() => _SetGroupNameState();
}

class _SetGroupNameState extends ConsumerState<SetGroupName> {
  final _nameController = TextEditingController();
  final _introController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 입력에 따라 에러 문구(_nameError)가 갱신되도록 rebuild.
    _nameController.addListener(_onNameChanged);
  }

  void _onNameChanged() => setState(() {});

  /// 모임 이름 최대 길이.
  static const _nameMaxLength = 20;

  /// 이름이 [_nameMaxLength] 를 초과하면 에러 문구, 아니면 null.
  String? get _nameError =>
      _nameController.text.length > _nameMaxLength ? '20자 이하로 입력해주세요' : null;

  @override
  void dispose() {
    _nameController.removeListener(_onNameChanged);
    _nameController.dispose();
    _introController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(createGroupNotifierProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.s1,
      children: [
        const TitleDescription(
          title: '모임 이름을 정해주세요',
          description: '내가 먼저 찍으면, 친구들이 따라 찍어요',
        ),
        // body 다음 간격 s6. (spacing s1 이 SizedBox 양옆에 붙으므로 s1+s4+s1=s6)
        const SizedBox(height: AppSpacing.s4),
        AppTextField(
          label: '모임 이름',
          placeholder: '예) 마라탕 걸즈',
          controller: _nameController,
          highlightWhenFilled: true,
          errorText: _nameError,
          onChanged: notifier.groupNameOnChanged,
        ),
        const SizedBox(height: AppSpacing.s4),
        AppTextField(
          label: '한 줄 소개 (선택)',
          placeholder: '어떤 모임인지 알려주세요',
          controller: _introController,
          highlightWhenFilled: true,
          onChanged: notifier.descriptionOnChanged,
        ),
      ],
    );
  }
}
