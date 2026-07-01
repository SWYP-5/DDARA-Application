import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/model/group/invite_group.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/feature/group/join/confirm/join_confirm_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// 모임 코드·초대 링크로 진입했을 때, 참여 전 모임 정보를 보여주고
/// 하단 '모임 참여하기' 로 참여를 확정하는 화면.
///
/// 본문은 [JoinConfirmBody] 로 분리돼 있고, 스캐폴드와 하단 버튼은 이 화면이
/// 들고 있다. (참여 버튼 클릭 후 본문만 다른 위젯으로 교체할 수 있도록 한 구조)
class JoinConfirmPage extends StatelessWidget {
  const JoinConfirmPage({
    super.key,
    required this.group,
    required this.onJoin,
  });

  /// 참여할 모임 정보. 초대 코드 조회 실패 시 null.
  final InviteGroup? group;

  /// '모임 참여하기' 를 눌렀을 때 실행할 콜백.
  final VoidCallback onJoin;

  /// 뒤로가기. 쌓인 스택이 있으면 pop, 없으면(초대 링크로 바로 진입) 홈으로 보낸다.
  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(RoutePath.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final group = this.group;
    // 조회 실패(null) 시 잘못된 초대 안내로 대체한다.
    final groupName = group?.name ?? '잘못된 초대입니다';
    final subtitle = group == null
        ? ''
        : '${_formatDate(group.createdAt.toLocal())} 개설 · ${group.memberCount}명';
    final memberSummary = group == null
        ? ''
        : group.memberCount <= 1
        ? '${group.ownerNickname}님이 함께하고 있어요'
        : '${group.ownerNickname}님 외 ${group.memberCount - 1}명이 함께하고 있어요';
    // 멤버 수만큼(1명이면 1개, 2명 이상이면 2개) 아바타를 보여준다.
    // 목록에 없거나 null(이미지 미설정)인 슬롯은 null 로 둬 기본 아바타로 표시한다.
    final memberAvatars = group?.memberAvatars ?? const <String?>[];
    final avatarCount = group == null ? 0 : (group.memberCount <= 1 ? 1 : 2);
    final memberAvatarUrls = List<String?>.generate(
      avatarCount,
      (i) => i < memberAvatars.length ? memberAvatars[i] : null,
    );

    return PopScope(
      // 스택이 없을 땐 기본 pop(앱 종료)을 막고 홈으로 보낸다.
      canPop: context.canPop(),
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.go(RoutePath.home);
      },
      child: CupertinoPageScaffold(
        navigationBar: AppBar(title: '모임 참여', onBack: () => _onBack(context)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: JoinConfirmBody(
                    groupName: groupName,
                    subtitle: subtitle,
                    memberSummary: memberSummary,
                    memberAvatarUrls: memberAvatarUrls,
                  ),
                ),
                AppButton(label: '모임 참여하기', onPressed: onJoin),
                const SizedBox(height: AppSpacing.s4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// DateTime → 'yyyy.MM.dd'.
String _formatDate(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}.$month.$day';
}
