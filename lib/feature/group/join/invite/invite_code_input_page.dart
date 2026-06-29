import 'package:ddara/core/designsystem/component/app_text_field.dart';
import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/core/widget/toast/toast.dart';
import 'package:ddara/feature/group/join/provider/notifier_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// 초대 딥링크(`kakao{KEY}://kakaolink?invite_code=...` 또는
/// `https://ddara.app/invite?code=...`)로 진입했을 때 보여줄 모임 참여 화면.
///
/// 딥링크에서 파싱한 [inviteCode] 가 있으면 입력 필드에 미리 채워준다.
/// 실제 참여 API 연동(research.md 작업 7번)은 백엔드 스펙 확정 후 연결한다.
class InviteCodeInputPage extends ConsumerStatefulWidget {
  const InviteCodeInputPage({super.key, required this.inviteCode});

  /// 딥링크로 전달받은 초대코드. (직접 입력으로 들어온 경우 빈 문자열)
  final String inviteCode;

  @override
  ConsumerState<InviteCodeInputPage> createState() =>
      _InviteCodeInputPageState();
}

class _InviteCodeInputPageState extends ConsumerState<InviteCodeInputPage> {
  late final TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    // 딥링크로 받은 코드가 있으면 입력값으로 미리 채운다.
    _codeController = TextEditingController(text: widget.inviteCode);

    // 미리 채워진 초대 코드를 State에도 반영한다.
    if (widget.inviteCode.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(inviteCodeInputNotifierProvider.notifier)
            .inviteCodeOnChanged(widget.inviteCode);
      });
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(inviteCodeInputNotifierProvider.notifier);

    ref.listen(inviteCodeInputNotifierProvider, (prev, next) {
      // 참여 성공 시 모임 홈으로 이동.
      if (prev?.groupId == -1 && next.groupId > -1) {
        context.pushReplacement(RoutePath.group, extra: next.groupId);
        return;
      }

      final errorCode = next.errorCode;

      if (errorCode != null) {
        Toast.showToast(context, errorCode.message, type: ToastType.error);
      }
    });

    return CupertinoPageScaffold(
      navigationBar: AppBar(title: '모임 참여', onBack: () => context.pop()),
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
              const AppText.headlineLarge('받은 초대 코드를 입력해주세요'),
              const AppText.body('링크로 받았다면, 링크만 눌러도 바로 들어올 수 있어요'),
              const SizedBox(height: AppSpacing.s2),
              AppTextField(
                label: '초대 코드',
                placeholder: '예) ASKD23NSK12',
                controller: _codeController,
                highlightWhenFilled: true,
                onChanged: notifier.inviteCodeOnChanged,
              ),
              const Spacer(),
              AppButton(
                label: '모임 참여하기',
                onPressed: () => notifier.joinGroup(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
