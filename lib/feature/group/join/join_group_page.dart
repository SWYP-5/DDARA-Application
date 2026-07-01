import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/model/group/invite_group.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/feature/group/join/confirm/join_confirm.dart';
import 'package:ddara/feature/group/widget/set_nickname.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// 모임 참여 흐름을 한 화면에서 두 스텝으로 진행한다.
///
/// - 0: 모임 정보 확인([JoinConfirm])
/// - 1: 모임에서 쓸 닉네임 입력([SetNickname])
///
/// AppBar·하단 버튼은 이 화면이 공유로 들고, 본문만 [IndexedStack] 으로 교체한다.
/// (두 스텝을 모두 살려둬 뒤로 가도 입력이 보존된다)
class JoinGroupPage extends StatefulWidget {
  const JoinGroupPage({super.key, required this.group});

  /// 참여할 모임 정보. 조회 실패 시 null.
  final InviteGroup? group;

  @override
  State<JoinGroupPage> createState() => _JoinGroupPageState();
}

class _JoinGroupPageState extends State<JoinGroupPage> {
  /// 현재 스텝. 0: 모임 정보 확인, 1: 닉네임.
  int _step = 0;

  /// 닉네임 입력값.
  String _nickname = '';

  InviteGroup? get _group => widget.group;

  /// 유효하고 참여 가능한 모임인지. (확인 스텝의 다음 진행 조건)
  bool get _canJoin {
    final group = _group;
    return group != null && !group.alreadyJoined && !group.isFull;
  }

  /// 닉네임 입력 에러 문구. (길이 미달·초과 시) 비어있을 땐 에러를 띄우지 않는다.
  String? _nicknameError(String nickname) {
    if (nickname.isNotEmpty && (nickname.length < 2 || nickname.length > 10)) {
      return '2~10자로 입력해주세요';
    }
    return null;
  }

  /// 뒤로가기: 닉네임 스텝이면 확인 스텝으로, 첫 스텝이면 pop(없으면 홈).
  void _handleBack() {
    if (_step > 0) {
      setState(() => _step = 0);
    } else if (context.canPop()) {
      context.pop();
    } else {
      context.go(RoutePath.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final group = widget.group;
    final nicknameError = _nicknameError(_nickname);

    // 스텝별 다음 진행 가능 조건.
    final canSubmit = switch (_step) {
      0 => _canJoin,
      _ => _nickname.length >= 2 && _nickname.length <= 10,
    };

    return PopScope(
      // 확인 스텝이고 pop 할 스택이 있을 때만 시스템 뒤로가기를 허용한다.
      canPop: _step == 0 && context.canPop(),
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (_step > 0) {
          setState(() => _step = 0);
        } else {
          context.go(RoutePath.home);
        }
      },
      child: CupertinoPageScaffold(
        navigationBar: AppBar(title: '모임 참여', onBack: _handleBack),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.s4,
              right: AppSpacing.s4,
              top: AppSpacing.s2,
              bottom: AppSpacing.s4,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: IndexedStack(
                    index: _step,
                    sizing: StackFit.expand,
                    children: [
                      JoinConfirm(group: group),
                      SetNickname(
                        groupName: group?.name ?? '',
                        onChanged: (value) =>
                            setState(() => _nickname = value),
                        errorText: nicknameError,
                      ),
                    ],
                  ),
                ),
                // 스텝 간 공유하는 하단 버튼.
                AppButton(
                  label: _step == 0 ? '모임 참여하기' : '시작하기',
                  onPressed: canSubmit
                      ? () {
                          if (_step == 0) {
                            setState(() => _step = 1);
                          } else {
                            // TODO: 닉네임과 함께 실제 모임 참여 API 연결 후 모임 홈으로 이동.
                          }
                        }
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
