import 'package:ddara/core/designsystem/component/button/app_text_button.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/share/kakao_share_service.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/widget/error_message_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 모임 초대 공유 BottomSheet.
///
/// 여러 화면에서 재사용할 수 있도록 [show] 정적 메서드로 띄운다.
///
/// ```dart
/// InviteShareSheet.show(context, inviteCode: 'A82TSJXk2', imageUrl: '<https-url>');
/// ```
class InviteShareSheet extends StatelessWidget {
  const InviteShareSheet({
    super.key,
    required this.inviteCode,
    required this.imageUrl,
  });

  /// 공유/복사에 사용할 초대코드 (백엔드 발급 문자열).
  final String inviteCode;

  /// 공유 카드에 넣을 모임 대표 이미지 (공개 https URL).
  final String imageUrl;

  /// 초대 공유 시트를 표시한다. (Cupertino 모달 팝업)
  static Future<void> show(
    BuildContext context, {
    required String inviteCode,
    required String imageUrl,
  }) {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (_) =>
          InviteShareSheet(inviteCode: inviteCode, imageUrl: imageUrl),
    );
  }

  Future<void> _onKakaoShare(BuildContext context) async {
    final navigator = Navigator.of(context);
    try {
      await KakaoShareService().shareInvite(inviteCode, imageUrl: imageUrl);
      navigator.pop();
    } catch (_) {
      // 공유 실패(미설치 폴백 실패 등) → 시트는 유지하고 안내.
      if (!context.mounted) return;
      _showShareError(context);
    }
  }

  void _showShareError(BuildContext context) {
    showErrorMessageDialog(
      context,
      title: '공유하지 못했어요',
      message: '잠시 후 다시 시도하거나 초대코드를 복사해 전달해주세요.',
    );
  }

  void _onCopyCode(BuildContext context) {
    Clipboard.setData(ClipboardData(text: inviteCode));
    Navigator.of(context).pop();
    // TODO: 복사 완료 피드백(토스트 등).
  }

  void _onMore(BuildContext context) {
    Navigator.of(context).pop();
    // TODO: share_plus 로 OS 기본 공유 시트.
  }

  void _onLater(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s5,
            AppSpacing.s3,
            AppSpacing.s5,
            AppSpacing.s7,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: AppSpacing.s3,
            children: [
              // 드래그 핸들
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.s4),
                decoration: const ShapeDecoration(
                  color: AppColors.borderStrong,
                  shape: StadiumBorder(),
                ),
              ),
              const AppText.headlineMedium(
                '함께할 친구를 초대해요',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.s2),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.s3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _CircleAction(
                      icon: SvgPicture.asset(
                        'assets/images/ic_kakao.svg',
                        width: 24,
                        height: 24,
                      ),
                      backgroundColor: const Color(0xFFFEE500), // 카카오 옐로
                      label: '카카오톡',
                      onTap: () => _onKakaoShare(context),
                    ),
                    _CircleAction(
                      icon: const Icon(
                        CupertinoIcons.doc_on_clipboard,
                        size: 24,
                        color: AppColors.textPrimary,
                      ),
                      label: '초대코드',
                      onTap: () => _onCopyCode(context),
                    ),
                    _CircleAction(
                      icon: const Icon(
                        CupertinoIcons.ellipsis,
                        size: 24,
                        color: AppColors.textPrimary,
                      ),
                      label: '더보기',
                      onTap: () => _onMore(context),
                    ),
                  ],
                ),
              ),
              AppTextButton.body(
                label: '나중에 할게요',
                onPressed: () => _onLater(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 동그란 배경 + 아이콘 버튼과 그 아래 caption 라벨. (시트 액션용)
class _CircleAction extends StatelessWidget {
  const _CircleAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.backgroundColor = AppColors.bgSurfaceAlt,
  });

  /// 원 안에 들어갈 아이콘 위젯 (Icon 또는 SvgPicture 등).
  final Widget icon;
  final String label;
  final VoidCallback onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.s2,
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          onPressed: onTap,
          child: Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: icon,
          ),
        ),
        AppText.caption(label),
      ],
    );
  }
}
