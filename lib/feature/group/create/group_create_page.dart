import 'package:ddara/core/designsystem/component/app_button.dart';
import 'package:ddara/core/designsystem/component/app_text_field.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/widget/app_description.dart';
import 'package:ddara/core/widget/app_title.dart';
import 'package:ddara/core/widget/invite_share_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class GroupCreatePage extends StatefulWidget {
  const GroupCreatePage({super.key});

  @override
  State<GroupCreatePage> createState() => _GroupCreatePageState();
}

class _GroupCreatePageState extends State<GroupCreatePage> {
  // TODO: 모임 생성 API 응답의 inviteCode 로 대체. (현재 백엔드 스펙 대기 — 임시 더미)
  static const _dummyInviteCode = 'A82TSJXk2';

  final _nameController = TextEditingController();
  final _introController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 모임 이름 입력 여부에 따라 '만들기' 버튼 활성화 상태가 바뀐다.
    _nameController.addListener(_onNameChanged);
  }

  void _onNameChanged() => setState(() {});

  /// 모임 이름이 비어있지 않아야 생성 가능.
  bool get _canSubmit => _nameController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _nameController.removeListener(_onNameChanged);
    _nameController.dispose();
    _introController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // sign_up_page 와 동일한 여백 규약.
        padding: const EdgeInsetsDirectional.only(start: 12, end: 16),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          onPressed: () => context.pop(),
          child: const Icon(CupertinoIcons.back, color: AppColors.textPrimary),
        ),
        middle: Text(
          '모임 만들기',
          style: AppTypography.headlineMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.s5,
            right: AppSpacing.s5,
            top: AppSpacing.s4,
            bottom: AppSpacing.s4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.s3,
            children: [
              const AppTitle('모임 이름을 설정해주세요.'),
              const AppDescription('내가 먼저 찍으면, 친구들이 이 주제를 따라 찍어요'),
              const SizedBox(height: AppSpacing.s2),
              AppTextField(
                label: '모임 이름',
                placeholder: '예) 마라탕 걸즈',
                controller: _nameController,
                highlightWhenFilled: true,
              ),
              const SizedBox(height: AppSpacing.s2),
              AppTextField(
                label: '한 줄 소개 (선택)',
                placeholder: '어떤 모임인지 알려주세요',
                controller: _introController,
                highlightWhenFilled: true,
              ),
              const Spacer(),
              AppButton(
                label: '만들기',
                onPressed: _canSubmit
                    ? () {
                        // TODO: 모임 생성 API 호출 → 응답 inviteCode 로 시트 오픈.
                        InviteShareSheet.show(
                          context,
                          inviteCode: _dummyInviteCode,
                        );
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
