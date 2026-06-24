import 'package:ddara/core/designsystem/component/app_button.dart';
import 'package:ddara/core/designsystem/component/app_text_field.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/widget/app_description.dart';
import 'package:ddara/core/widget/app_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// 초대 딥링크(`kakao{KEY}://kakaolink?invite_code=...` 또는
/// `https://ddara.app/invite?code=...`)로 진입했을 때 보여줄 모임 참여 화면.
///
/// 딥링크에서 파싱한 [inviteCode] 가 있으면 입력 필드에 미리 채워준다.
/// 실제 참여 API 연동(research.md 작업 7번)은 백엔드 스펙 확정 후 연결한다.
class GroupJoinPage extends StatefulWidget {
  const GroupJoinPage({super.key, required this.inviteCode});

  /// 딥링크로 전달받은 초대코드. (직접 입력으로 들어온 경우 빈 문자열)
  final String inviteCode;

  @override
  State<GroupJoinPage> createState() => _GroupJoinPageState();
}

class _GroupJoinPageState extends State<GroupJoinPage> {
  late final TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    // 딥링크로 받은 코드가 있으면 입력값으로 미리 채운다.
    _codeController = TextEditingController(text: widget.inviteCode);
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: const EdgeInsetsDirectional.only(start: 12, end: 16),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          onPressed: () => context.pop(),
          child: const Icon(CupertinoIcons.back, color: AppColors.textPrimary),
        ),
        middle: Text(
          '모임 참여',
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
              const AppTitle('받은 초대 코드를 입력해주세요'),
              const AppDescription('링크로 받았다면, 링크만 눌러도 바로 들어올 수 있어요'),
              const SizedBox(height: AppSpacing.s2),
              AppTextField(
                label: '초대 코드',
                placeholder: '예) ASKD23NSK12',
                controller: _codeController,
                highlightWhenFilled: true,
              ),
              const Spacer(),
              AppButton(
                label: '모임 참여하기',
                onPressed: () {
                  // TODO: 모임 참여 API 연동 (research.md 작업 7번 — 백엔드 스펙 대기).
                  //  POST /groups/join { inviteCode } → 성공 시 모임 홈으로 이동.
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
