import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;

/// 모임 카드 한 칸의 표시 데이터.
///
/// TODO: 모임 조회 API 의 모임 요약 모델로 대체. (백엔드 스펙 대기 — 임시 record)
typedef GroupSummary = ({
  /// 모임 이름. (예: '동아리 친구들')
  String name,

  /// 대표 이미지 경로. (현재는 에셋 경로 — API 연동 시 네트워크 URL 로 대체)
  String imageUrl,

  /// 멤버 요약. (예: '민주님 외 4명')
  String memberSummary,

  /// 날짜. (예: '06.12')
  String date,

  /// 진행 상태. (예: '진행 중')
  String status,
});

/// 모임 카드. (대표 이미지 위에 상태·이름·멤버 요약을 얹은 형태) — 비율 균일
class MeetingCard extends StatelessWidget {
  const MeetingCard({super.key, required this.group, required this.onTap});

  final GroupSummary group;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: onTap,
      // 디자인 기준 186×245 비율. 폭은 열에 맞춰 stretch 되고 높이는 비율로 따라간다.
      child: AspectRatio(
        aspectRatio: 186 / 245,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: AppColors.bgSurfaceAlt,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
          ),
          child: Stack(
            children: [
              // 대표 이미지. (카드 전체를 채운다)
              // TODO: API 연동 시 네트워크 URL 이면 Image.network 로 분기. (현재는 에셋)
              Positioned.fill(
                child: Image.asset(group.imageUrl, fit: BoxFit.cover),
              ),
              // 상단: 날짜 · 진행 상태 (우측 정렬)
              Positioned(
                top: AppSpacing.s3,
                left: AppSpacing.s3,
                right: AppSpacing.s3,
                child: AppText.caption(
                  '${group.date} · ${group.status}',
                  color: AppColors.textPrimary,
                  textAlign: TextAlign.right,
                ),
              ),
              // 하단: 텍스트 가독성을 위한 그라데이션 + 이름 · 멤버 요약
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s3,
                    vertical: AppSpacing.s3,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(0.50, 1.00),
                      end: const Alignment(0.50, 0.26),
                      colors: [Colors.black, Colors.black.withValues(alpha: 0)],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSpacing.s1,
                    children: [
                      AppText.title(
                        group.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AppText.caption(group.memberSummary),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
