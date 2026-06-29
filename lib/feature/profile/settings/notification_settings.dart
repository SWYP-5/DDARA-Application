import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/permission/permission_service.dart';
import 'package:ddara/core/permission/provider/permission_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// 알림 설정 화면.
class NotificationSettings extends ConsumerStatefulWidget {
  const NotificationSettings({super.key});

  @override
  ConsumerState<NotificationSettings> createState() =>
      _NotificationSettingsState();
}

class _NotificationSettingsState extends ConsumerState<NotificationSettings>
    with WidgetsBindingObserver {
  /// OS 알림 권한 허용 여부.
  bool _permissionGranted = false;

  /// 사용자가 앱 내에서 알림을 켜둔 선호값. (권한이 있어도 끌 수 있다)
  ///
  /// TODO: 서버 저장 연동 보류 중. 현재는 메모리에만 유지되어 앱 재시작 시
  /// 기본값(on)으로 돌아간다.
  bool _userEnabled = true;

  /// '알림 허용' 토글의 실제 표시값. 권한과 사용자 선호가 모두 켜져야 on.
  bool get _allowNotification => _permissionGranted && _userEnabled;

  /// '따라찍기 차례' 알림 여부.
  bool _myTurn = true;

  /// '마감·투표 알림' 여부.
  bool _deadlineVote = true;

  /// '친구 참여 알림' 여부.
  bool _friendJoin = true;

  @override
  void initState() {
    super.initState();
    // 설정 화면에서 권한을 바꾸고 돌아오는 경우까지 반영하기 위해 옵저버 등록.
    WidgetsBinding.instance.addObserver(this);
    _syncPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // OS 설정에서 권한을 변경하고 앱으로 복귀하면 토글을 최신 상태로 맞춘다.
    if (state == AppLifecycleState.resumed) _syncPermission();
  }

  /// 현재 OS 알림 권한 상태만 반영한다. (사용자 선호 [_userEnabled] 는 건드리지
  /// 않아, 권한을 가진 채 꺼둔 사용자의 선택을 덮어쓰지 않는다.)
  Future<void> _syncPermission() async {
    final granted = await ref
        .read(permissionServiceProvider)
        .isNotificationGranted();
    if (mounted) setState(() => _permissionGranted = granted);
  }

  /// '알림 허용' 토글 변경.
  ///
  /// 끄면 권한이 있어도 사용자 선호만 끈다. 켜면 선호를 켜고, 권한이 없으면
  /// OS 권한을 요청한다.
  Future<void> _onAllowChanged(bool value) async {
    // TODO: 변경된 _userEnabled 를 서버에 저장. (현재 보류)
    setState(() => _userEnabled = value);
    if (!value) return;

    // 켜는데 이미 권한이 있으면 추가 요청은 필요 없다.
    if (_permissionGranted) return;

    final result = await ref
        .read(permissionServiceProvider)
        .requestNotification();
    if (!mounted) return;

    setState(() => _permissionGranted = result == PermissionResult.granted);

    // 영구 거부면 프롬프트가 더 뜨지 않으므로 설정으로 안내한다.
    if (result == PermissionResult.permanentlyDenied) {
      _showOpenSettingsDialog();
    }
  }

  /// 알림 권한이 영구 거부됐을 때, 설정 이동을 안내하는 다이얼로그.
  void _showOpenSettingsDialog() {
    showCupertinoDialog<void>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: const Text('알림 권한 필요'),
        content: const Text('알림을 받으려면 설정에서 알림 권한을 허용해 주세요.'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('취소'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(dialogContext).pop();
              ref.read(permissionServiceProvider).openSettings();
            },
            child: const Text('설정으로 이동'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: AppBar(title: '알림 설정', onBack: () => context.pop()),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppSpacing.s3,
            left: AppSpacing.s4,
            right: AppSpacing.s4,
            bottom: AppSpacing.s6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.s5,
            children: [
              _SettingCard(
                children: [
                  _ToggleRow(
                    label: '알림 허용',
                    value: _allowNotification,
                    onChanged: _onAllowChanged,
                  ),
                ],
              ),
              // 알림을 끄면 세부 설정 섹션을 숨긴다.
              if (_allowNotification) ...[
                _SettingCard(
                  children: [
                    AppText.caption('활동'),
                    _ToggleRow(
                      label: '따라찍기 차례',
                      caption: '새 따라찍기가 열리거나 내 차례일 때',
                      value: _myTurn,
                      onChanged: (value) => setState(() => _myTurn = value),
                    ),
                    _ToggleRow(
                      label: '마감·투표 알림',
                      caption: '따라찍기 마감 · 베스트 투표',
                      value: _deadlineVote,
                      onChanged: (value) =>
                          setState(() => _deadlineVote = value),
                    ),
                  ],
                ),
                _SettingCard(
                  children: [
                    AppText.caption('기타'),
                    _ToggleRow(
                      label: '친구 참여 알림',
                      caption: '내가 보낸 초대를 친구가 받았을 때',
                      value: _friendJoin,
                      onChanged: (value) => setState(() => _friendJoin = value),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// 알림 설정 항목을 담는 카드.
///
/// bg-surface 배경의 둥근 카드 안에 [children] 을 세로로 쌓고, 항목 사이에는
/// [AppSpacing.s4] 간격을 둔다. (카드 자체가 좌우 [AppSpacing.s5]·상하
/// [AppSpacing.s3] 패딩을 갖는다.)
class _SettingCard extends StatelessWidget {
  const _SettingCard({required this.children});

  /// 카드 내부에 세로로 쌓을 항목들.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s5,
        vertical: AppSpacing.s3,
      ),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.s4,
        children: children,
      ),
    );
  }
}

/// [_SettingCard] 안에 들어가는 "라벨 + 토글" 행.
///
/// [caption] 이 없으면 라벨을 headlineMedium 으로 보여주는 상위 토글(예: '알림
/// 허용')이고, [caption] 이 있으면 body(textPrimary) 라벨 아래에 caption 설명을
/// 덧붙인 개별 항목 토글이다.
class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
    this.caption,
  });

  /// 항목 이름. (예: '알림 허용')
  final String label;

  /// 라벨 아래 보조 설명. null 이면 라벨만 보여준다.
  final String? caption;

  /// 토글 켜짐 여부.
  final bool value;

  /// 토글이 바뀔 때 실행할 콜백.
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final caption = this.caption;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: caption == null
              ? AppText.headlineMedium(label)
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.s1,
                  children: [
                    AppText.body(label, color: AppColors.textPrimary),
                    AppText.caption(caption),
                  ],
                ),
        ),
        const SizedBox(width: AppSpacing.s3),
        CupertinoSwitch(
          value: value,
          activeTrackColor: AppColors.accentDefault,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
