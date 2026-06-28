import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 아바타 원 지름.
const double _avatarSize = 40;

/// 알림 한 건의 표시 데이터.
///
/// TODO: 알림 조회 API 모델로 대체. (백엔드 스펙 대기 — 임시 record)
typedef NotificationDisplay = ({
  /// 알림 분류 라벨. (예: '모임 합류')
  String category,

  /// 본문 내용. (예: '지원님이 ‘마라탕 맛있게 먹기’ 모임에 합류했어요')
  String message,

  /// 표시용 경과 시간 문자열. (예: '5분 전')
  String timeAgo,

  /// 관련 프로필 이미지 URL. null·빈 값이면 기본 아바타를 보여준다.
  String? imageUrl,
});

/// 알림 목록의 항목 한 개.
///
/// 좌측 원형 아바타 + 우측(분류 라벨·경과 시간 한 줄 / 본문) 으로 구성된 카드.
/// [onTap] 을 주면 카드 전체가 눌리는 영역이 된다.
class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.data, this.onTap});

  final NotificationDisplay data;

  /// 카드 탭 콜백. null 이면 탭에 반응하지 않는다.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bgSurface,
      borderRadius: BorderRadius.circular(AppRadius.md),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          // 우측은 시간 텍스트가 모서리에 붙지 않도록 넓게 둔다.
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s4,
            AppSpacing.s4,
            AppSpacing.s6,
            AppSpacing.s4,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.s3,
            children: [
              _Avatar(imageUrl: data.imageUrl),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.s2,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppSpacing.s1,
                      children: [
                        Expanded(
                          child: AppText.caption(
                            data.category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        AppText.caption(
                          data.timeAgo,
                          color: AppColors.textTertiary,
                        ),
                      ],
                    ),
                    AppText.body(data.message, color: AppColors.textPrimary),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 알림 주체의 원형 아바타. 이미지가 없으면 기본 아바타 실루엣을 보여준다.
class _Avatar extends StatelessWidget {
  const _Avatar({required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    final hasImage = url != null && url.isNotEmpty;

    return Container(
      width: _avatarSize,
      height: _avatarSize,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: AppColors.bgSurfaceAlt,
        shape: BoxShape.circle,
        border: Border.fromBorderSide(
          BorderSide(color: AppColors.borderDefault),
        ),
      ),
      child: hasImage
          ? Image.network(
              url,
              fit: BoxFit.cover,
              // 로드 실패 시 기본 아바타로 대체.
              errorBuilder: (context, error, stackTrace) =>
                  const _DefaultAvatar(),
            )
          : const _DefaultAvatar(),
    );
  }
}

/// 이미지가 없거나 로드 실패했을 때의 기본 아바타.
class _DefaultAvatar extends StatelessWidget {
  const _DefaultAvatar();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/ic_avatar.svg',
      width: _avatarSize,
      height: _avatarSize,
      fit: BoxFit.cover,
    );
  }
}