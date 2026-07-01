import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/core/widget/toast/toast.dart';
import 'package:ddara/feature/group/create/provider/notifier_provider.dart';
import 'package:ddara/feature/group/create/widget/set_group_name.dart';
import 'package:ddara/feature/group/widget/set_nickname.dart';
import 'package:ddara/feature/home/provider/notifier_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GroupCreatePage extends ConsumerStatefulWidget {
  const GroupCreatePage({super.key});

  @override
  ConsumerState<GroupCreatePage> createState() => _GroupCreatePageState();
}

class _GroupCreatePageState extends ConsumerState<GroupCreatePage> {
  /// 현재 스텝. 0: 모임 이름, 1: 닉네임.
  int _step = 0;

  /// 뒤로가기: 닉네임 스텝이면 이름 스텝으로, 첫 스텝이면 화면을 닫는다.
  void _handleBack() {
    if (_step > 0) {
      setState(() => _step = 0);
    } else {
      context.pop();
    }
  }

  /// 닉네임 입력 에러 문구. (길이 미달·초과 시)
  /// 비어있을 땐 에러를 띄우지 않는다.
  String? _nicknameError(String nickname) {
    if (nickname.isNotEmpty && (nickname.length < 2 || nickname.length > 10)) {
      return '2~10자로 입력해주세요';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createGroupNotifierProvider);
    final notifier = ref.read(createGroupNotifierProvider.notifier);

    final nicknameError = _nicknameError(state.nickname);

    // 스텝별 다음 진행 가능 조건.
    final canSubmit = switch (_step) {
      0 => state.groupName.trim().isNotEmpty && state.groupName.length <= 20,
      _ => state.nickname.length >= 2 && state.nickname.length <= 10,
    };

    ref.listen(createGroupNotifierProvider, (prev, next) {
      if (prev?.createGroupId == -1 && next.createGroupId > -1) {
        // 홈 목록을 무효화해, 상세에서 뒤로 돌아왔을 때 새 모임이 반영되게 한다.
        // (HomePage 는 스택에 남아 있어 재조회가 자동으로 일어나지 않는다)
        ref.invalidate(homeNotifierProvider);
        context.pushReplacement(RoutePath.group, extra: next.createGroupId);
        return;
      }

      final errorMessage = next.errorMessage;

      if (errorMessage.isNotEmpty) {
        Toast.showToast(context, errorMessage, type: ToastType.error);
      }
    });

    return PopScope(
      // 닉네임 스텝에선 시스템 뒤로가기를 가로채 이름 스텝으로 되돌린다.
      canPop: _step == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        setState(() => _step = 0);
      },
      child: CupertinoPageScaffold(
        navigationBar: AppBar(title: '모임 만들기', onBack: _handleBack),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.s4,
              right: AppSpacing.s4,
              top: AppSpacing.s2,
              bottom: AppSpacing.s6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 두 스텝을 모두 살려둬(컨트롤러 유지) 뒤로 가도 입력이 보존된다.
                IndexedStack(
                  index: _step,
                  sizing: StackFit.loose,
                  children: [
                    const SetGroupName(),
                    SetNickname(
                      groupName: state.groupName,
                      onChanged: notifier.nicknameOnChanged,
                      errorText: nicknameError,
                    ),
                  ],
                ),
                const Spacer(),
                // 스텝 간 공유하는 하단 버튼.
                AppButton(
                  label: _step == 0 ? '다음' : '시작하기',
                  onPressed: canSubmit
                      ? () {
                          if (_step == 0) {
                            setState(() => _step = 1);
                          } else {
                            notifier.createGroup();
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
