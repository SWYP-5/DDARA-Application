import 'package:ddara/core/designsystem/component/app_text_field.dart';
import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/core/widget/toast/toast.dart';
import 'package:ddara/feature/group/join/provider/notifier_provider.dart';
import 'package:ddara/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// 초대 딥링크(`kakao{KEY}://kakaolink?invite_code=...` 또는
/// `https://ddara.app/invite?code=...`)로 진입했을 때 보여줄 모임 참여 화면.
///
/// 딥링크에서 파싱한 [inviteCode] 가 있으면 입력 필드에 미리 채워준다.
/// 실제 참여 API 연동(research.md 작업 7번)은 백엔드 스펙 확정 후 연결한다.
class GroupJoinPage extends ConsumerStatefulWidget {
  const GroupJoinPage({super.key, required this.inviteCode});

  /// 딥링크로 전달받은 초대코드. (직접 입력으로 들어온 경우 빈 문자열)
  final String inviteCode;

  @override
  ConsumerState<GroupJoinPage> createState() => _GroupJoinPageState();
}

class _GroupJoinPageState extends ConsumerState<GroupJoinPage> {
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
            .read(groupJoinNotifierProvider.notifier)
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
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(groupJoinNotifierProvider.notifier);

    ref.listen(groupJoinNotifierProvider, (prev, next) {
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
      navigationBar: AppBar(title: l10n.groupJoinTitle, onBack: () => context.pop()),
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
              AppText.headlineLarge(l10n.groupJoinHeadline),
              AppText.body(l10n.groupJoinSubtitle),
              const SizedBox(height: AppSpacing.s2),
              AppTextField(
                label: l10n.groupJoinCodeLabel,
                placeholder: l10n.groupJoinCodePlaceholder,
                controller: _codeController,
                highlightWhenFilled: true,
                onChanged: notifier.inviteCodeOnChanged,
              ),
              const Spacer(),
              AppButton(
                label: l10n.groupJoin,
                onPressed: () => notifier.joinGroup(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
