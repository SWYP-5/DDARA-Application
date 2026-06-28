import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/widget/profile_avatar.dart';
import 'package:flutter/material.dart';

/// 알림 아바타 원 지름.
const double _avatarSize = 40;

/// 읽지 않음 표시 점의 지름.
const double _unreadDotSize = 8;

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

  /// 읽음 여부. false 면 우측 상단에 읽지 않음 표시 점을 보여준다.
  bool isRead,
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
              ProfileAvatar(size: _avatarSize, imageUrl: data.imageUrl),
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
                        // 읽지 않은 알림이면 시간 텍스트의 우측 상단 모서리에 점을 띄운다.
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            AppText.caption(
                              data.timeAgo,
                              color: AppColors.textTertiary,
                            ),
                            if (!data.isRead)
                              // 카드 상단 padding(s4) 기준 indicator 와 상단 간격이 s3 가
                              // 되도록 (s4 - s3)=s1 만큼 위로 올린다. 우측도 카드 우측
                              // padding(s6) 기준 간격이 s3 가 되도록 s3 만큼 내민다.
                              const Positioned(
                                top: -AppSpacing.s1,
                                right: -AppSpacing.s3,
                                child: _UnreadDot(),
                              ),
                          ],
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

/// 읽지 않은 알림임을 나타내는 빨간 점.
class _UnreadDot extends StatelessWidget {
  const _UnreadDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _unreadDotSize,
      height: _unreadDotSize,
      decoration: const BoxDecoration(
        color: AppColors.statusDanger,
        shape: BoxShape.circle,
      ),
    );
  }
}