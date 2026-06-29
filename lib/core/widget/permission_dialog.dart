import 'package:ddara/core/permission/permission_service.dart';
import 'package:flutter/cupertino.dart';

/// 권한이 영구 거부된 상태에서 앱 설정으로 이동하도록 안내하는 다이얼로그.
///
/// '설정으로 이동' 선택 시 [PermissionService.openSettings] 를 호출하고 true 를,
/// '취소' 선택 시 false 를 반환한다.
Future<bool?> showPermissionDialog(
  BuildContext context, {
  required PermissionService permission,
  required String permissionName,
}) {
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
