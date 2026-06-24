import 'package:ddara/core/designsystem/theme/app_colors.dart';
import 'package:ddara/core/designsystem/theme/app_typography.dart';
import 'package:flutter/cupertino.dart';

/// 앱 공통 상단 바. ([CupertinoPageScaffold.navigationBar] 에 사용)
///
/// - 기본: 좌측 뒤로가기 버튼 + 가운데 제목.
/// - [showBackButton] 이 false 면 뒤로가기 버튼을 숨긴다. (제목만 표시 등)
/// - [leading] 을 지정하면 뒤로가기 버튼 대신 그 위젯을 사용한다. (예: 홈 로고)
/// - [trailing] 으로 우측 액션(알림/프로필 등)을 둘 수 있다.
///
/// ```dart
/// // 뒤로가기 + 제목
/// AppBar(title: '모임 만들기')
/// // 제목만
/// AppBar(title: '권한 안내', showBackButton: false)
/// // 커스텀 leading/trailing
/// AppBar(showBackButton: false, leading: Logo(), trailing: ...)
/// ```
class AppBar extends StatelessWidget implements ObstructingPreferredSizeWidget {
  const AppBar({
    super.key,
    this.title,
    this.onBack,
    this.showBackButton = true,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.padding = const EdgeInsetsDirectional.only(start: 12, end: 16),
  });

  /// 가운데 제목. null 이면 제목을 표시하지 않는다.
  final String? title;

  /// 뒤로가기 콜백. null 이면 기본 동작([Navigator.maybePop])을 한다.
  final VoidCallback? onBack;

  /// 뒤로가기 버튼 표시 여부. ([leading] 이 지정되면 무시)
  final bool showBackButton;

  /// 좌측 커스텀 위젯. 지정 시 뒤로가기 버튼 대신 사용한다.
  final Widget? leading;

  /// 우측 액션 위젯.
  final Widget? trailing;

  /// 배경색. null 이면 Cupertino 테마 기본값.
  final Color? backgroundColor;

  /// 좌우 여백.
  final EdgeInsetsDirectional padding;

  @override
  Widget build(BuildContext context) {
    final leadingWidget =
        leading ??
        (showBackButton
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                child: const Icon(
                  CupertinoIcons.back,
                  color: AppColors.textPrimary,
                ),
              )
            : null);

    return CupertinoNavigationBar(
      // leading 은 항상 직접 제어한다.
      automaticallyImplyLeading: false,
      padding: padding,
      backgroundColor: backgroundColor,
      leading: leadingWidget,
      trailing: trailing,
      middle: title == null
          ? null
          : Text(
              title!,
              style: AppTypography.headlineMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    final bg =
        CupertinoDynamicColor.maybeResolve(
          backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor,
          context,
        ) ??
        const Color(0x00000000);
    return bg.a >= 1.0;
  }
}
