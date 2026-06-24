import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/permission/permission_service.dart';
import 'package:ddara/core/permission/provider/permission_provider.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/feature/permission/widget/permission_item.dart';
import 'package:ddara/feature/permission/widget/section_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PermissionPage extends ConsumerWidget {
  const PermissionPage({super.key});

  /// 확인 버튼: 카메라부터 순차로 권한을 요청한다.
  /// - 허용 → 홈
  /// - 이번 요청에서 프롬프트가 떴고 거부됨 → 필수 권한 안내 페이지
  /// - 이미 영구 거부라 프롬프트가 안 뜨는 경우 → 설정 안내 다이얼로그('취소' 시 필수 권한 안내)
  Future<void> _onConfirm(BuildContext context, WidgetRef ref) async {
    final permission = ref.read(permissionServiceProvider);

    // 요청 '전' 상태로 프롬프트가 뜰지 판단한다.
    // (iOS 는 첫 거부에도 결과가 permanentlyDenied 로 와서, 결과만으론 구분 불가)
    final wasBlocked = await permission.isCameraPermanentlyDenied();

    // 카메라 → 알림 → 저장공간 순차 요청
    final cameraResult = await permission.requestCamera();
    await permission.requestNotification();
    await permission.requestPhotos();

    if (!context.mounted) return;

    // 카메라 허용 → 홈
    if (cameraResult == PermissionResult.granted) {
      ref.read(cameraNoticeAcknowledgedProvider.notifier).state = true;
      context.go(RoutePath.home);
      return;
    }

    // 이미 영구 거부라 프롬프트가 안 뜨는 경우에만 설정 안내.
    // '설정으로 이동' 시 머무르고, '취소' 시 필수 권한 안내 페이지로 이동.
    if (wasBlocked) {
      final goSettings = await _showSettingsDialog(context, permission, '카메라');
      if (goSettings == true) return;
      if (!context.mounted) return;
    }

    // 프롬프트가 떴고 거부됐거나, 설정 다이얼로그에서 취소 → 필수 권한 안내 페이지
    context.go(RoutePath.requiredPermission);
  }

  /// 권한을 요청하고, 영구 거부 상태면 설정 이동 안내를 띄운다.
  Future<void> _request(
    BuildContext context,
    PermissionService permission,
    String permissionName,
    Future<PermissionResult> Function() request,
  ) async {
    final result = await request();
    if (result != PermissionResult.permanentlyDenied) return;
    if (!context.mounted) return;

    await _showSettingsDialog(context, permission, permissionName);
  }

  /// 영구 거부 상태에서 앱 설정으로 이동하도록 안내하는 다이얼로그.
  /// '설정으로 이동' 선택 시 true, '취소' 선택 시 false 를 반환한다.
  Future<bool?> _showSettingsDialog(
    BuildContext context,
    PermissionService permission,
    String permissionName,
  ) {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: Text('$permissionName 권한이 필요해요'),
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
    final permission = ref.read(permissionServiceProvider);

    return CupertinoPageScaffold(
      navigationBar: const AppBar(title: '권한 안내', showBackButton: false),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(
            top: 8,
            left: 20,
            right: 20,
            bottom: 16,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              // 헤더
              const SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    AppText.headlineLarge('ddara 권한 안내'),
                    AppText.body('꼭 필요한 순간에만 권한을 요청해요.\n요청이 뜨면 허용해 주시면 돼요'),
                  ],
                ),
              ),

              // 필수 접근 권한
              const SectionLabel('필수 접근 권한'),
              PermissionItem(
                icon: CupertinoIcons.camera,
                title: '카메라',
                description: '따라찍기 사진을 촬영할 때 사용해요',
                onTap: () => _request(
                  context,
                  permission,
                  '카메라',
                  permission.requestCamera,
                ),
              ),

              // 선택 접근 권한
              const SectionLabel('선택 접근 권한'),
              PermissionItem(
                icon: CupertinoIcons.bell,
                title: '알림',
                description: '마감·투표·초대 소식이 있을 때 알려드려요',
                onTap: () => _request(
                  context,
                  permission,
                  '알림',
                  permission.requestNotification,
                ),
              ),
              PermissionItem(
                icon: CupertinoIcons.photo,
                title: '저장공간',
                description: '앨범에서 사진을 올릴 때 사용해요',
                onTap: () => _request(
                  context,
                  permission,
                  '저장공간',
                  permission.requestPhotos,
                ),
              ),

              const Spacer(),

              // 하단 확인 버튼
              AppButton(label: '확인', onPressed: () => _onConfirm(context, ref)),
            ],
          ),
        ),
      ),
    );
  }
}
