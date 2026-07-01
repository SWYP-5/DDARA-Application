import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/design_system.dart';
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
    required this.groupName,
    required this.subtitle,
    required this.memberSummary,
    required this.memberImageUrls,
    required this.onJoin,
  });

  /// 참여할 모임 이름.
  final String groupName;

  /// 이름 아래 보조 정보. (예: '2026. 06.28 개설 · 7명')
  final String subtitle;

  /// 멤버 아바타 묶음 아래 요약. (예: '마라탕 킬러님 외 2명이 함께하고 있어요')
  final String memberSummary;

  /// 멤버 아바타 이미지 URL 목록.
  final List<String> memberImageUrls;

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
                    memberImageUrls: memberImageUrls,
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
