import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:flutter/cupertino.dart';

/// 앱 공통 확인 다이얼로그.
///
/// 가운데 [title] 아래에 취소/확인 두 버튼을 둔다. 확인=true, 취소(또는 바깥
/// 탭)=false 를 반환한다. 보통 [AppDialog.show] 로 띄우고 반환값으로 분기한다.
///
/// ```dart
/// final ok = await AppDialog.show(
///   context,
///   title: '로그아웃 할까요?',
///   confirmLabel: '로그아웃',
/// );
/// if (ok) await _logout();
/// ```
class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.confirmLabel,
    this.cancelLabel = '취소',
  });

  /// 가운데 정렬되는 제목.
  final String title;

  /// 확인(주요 동작) 버튼 라벨.
  final String confirmLabel;

  /// 취소 버튼 라벨.
  final String cancelLabel;

  /// 다이얼로그를 띄우고 결과를 받는다. 확인=true / 취소·바깥 탭=false.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String confirmLabel,
    String cancelLabel = '취소',
  }) async {
    final result = await showCupertinoDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (_) => AppDialog(
        title: title,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s6),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 328),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.bgSurface,
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSpacing.s7,
                    left: AppSpacing.s6,
                    right: AppSpacing.s6,
                    bottom: AppSpacing.s6,
                  ),
                  child: AppText.headlineMedium(
                    title,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSpacing.s3,
                    left: AppSpacing.s5,
                    right: AppSpacing.s5,
                    bottom: AppSpacing.s6,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton.outline(
                          label: cancelLabel,
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.s2),
                      Expanded(
                        child: AppButton(
                          label: confirmLabel,
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
