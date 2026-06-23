import 'package:ddara/core/designsystem/component/app_button.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/permission/permission_service.dart';
import 'package:ddara/core/permission/provider/permission_provider.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// 필수 권한 허용 안내 페이지.
class RequiredPermissionPage extends ConsumerWidget {
  const RequiredPermissionPage({super.key});

  /// 확인 버튼: 카메라 권한을 다시 요청한다.
  /// - 허용 → 홈 이동
  /// - 비허용:
  ///   - iOS: 프로그래밍 방식 종료 불가 → 설정 유도 다이얼로그 띄우고 머무름
  ///   - Android: 영구 거부면 설정 안내 후 '취소' 시 앱 종료 / 일반 거부면 앱 종료
  Future<void> _onConfirm(BuildContext context, WidgetRef ref) async {
    final permission = ref.read(permissionServiceProvider);
    final result = await permission.requestCamera();

    // 허용 → 홈
    if (result == PermissionResult.granted) {
      ref.read(cameraNoticeAcknowledgedProvider.notifier).state = true;
      if (!context.mounted) return;
      context.go(RoutePath.home);
      return;
    }

    if (!context.mounted) return;

    // iOS: 앱 종료가 막혀 있으므로 설정 유도 다이얼로그만 띄우고 화면에 머무른다.
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await _showSettingsDialog(context, permission);
      return;
    }

    // Android: 영구 거부면 설정 안내 후 '취소' 시 종료, 일반 거부면 바로 종료.
    if (result == PermissionResult.permanentlyDenied) {
      final goSettings = await _showSettingsDialog(context, permission);
      if (goSettings == true) return;
    }
    SystemNavigator.pop();
  }

  /// 영구 거부 시 설정 이동 안내 다이얼로그.
  /// '설정으로 이동' 선택 시 true, '취소' 선택 시 false 를 반환한다.
  Future<bool?> _showSettingsDialog(
    BuildContext context,
    PermissionService permission,
  ) {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: const Text('카메라 권한이 필요해요'),
        content: const Text('설정 > 권한에서 직접 허용해 주세요.'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('취소'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(dialogContext).pop(true);
              permission.openSettings();
            },
            child: const Text('설정으로 이동'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/permission.png',
                    ),
                    const SizedBox(height: AppSpacing.s3),
                    Text(
                      '필수 권한을 허용해 주세요',
                      textAlign: TextAlign.center,
                      style: AppTypography.headlineLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s3),
                    Text(
                      '필수 권한을 거부하면 ddara를\n정상적으로 이용할 수 없어요.\n권한이 필요할 때 허용해 주세요.',
                      textAlign: TextAlign.center,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // 하단 확인 버튼
              AppButton(
                label: '확인',
                onPressed: () => _onConfirm(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
