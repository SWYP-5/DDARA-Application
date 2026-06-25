import 'package:flutter/cupertino.dart';

/// 에러/안내 메시지를 알리는 단순 알림 다이얼로그. (메시지 + 확인 버튼)
///
/// 제목이 필요하면 [title] 을 넘긴다.
Future<void> showErrorMessageDialog(
  BuildContext context, {
  required String message,
  String? title,
  String confirmText = '확인',
}) {
  return showCupertinoDialog(
    context: context,
    builder: (dialogContext) => CupertinoAlertDialog(
      title: title == null ? null : Text(title),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(confirmText),
        ),
      ],
    ),
  );
}
