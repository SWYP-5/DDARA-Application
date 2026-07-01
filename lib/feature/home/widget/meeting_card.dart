import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/model/group/group_list.dart';
import 'package:ddara/core/widget/effect/bottom_scrim.dart';
import 'package:ddara/core/widget/empty_thumbnail.dart';
import 'package:ddara/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';

/// 모임 카드. (대표 이미지 위에 상태·이름·멤버 요약을 얹은 형태) — 비율 균일
class MeetingCard extends StatelessWidget {
  const MeetingCard({super.key, required this.group, required this.onTap});

  final Group group;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cycle = group.currentCycle;

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
              // 대표 이미지(진행 사이클 썸네일). 없거나 로드 실패면 갤러리 아이콘.
              Positioned.fill(
                child: cycle?.thumbnailUrl != null
                    ? Image.network(
                        cycle!.thumbnailUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const EmptyThumbnail(),
                      )
                    : const EmptyThumbnail(),
              ),
              // 하단 스크림. (텍스트 가독성 + 하단 경계를 배경과 자연스럽게 잇기)
              const BottomScrim(),
              // 상단: 시작일 · 진행 상태 (진행 중인 사이클이 있을 때만)
              if (cycle != null)
                Positioned(
                  top: AppSpacing.s3,
                  left: AppSpacing.s3,
                  right: AppSpacing.s3,
                  child: AppText.caption(
                    '${_formatDate(cycle.startedAt)} · ${_statusLabel(l10n, cycle.status)}',
                    color: AppColors.textPrimary,
                    textAlign: TextAlign.right,
                  ),
                ),
              // 하단: 이름 · 멤버 요약 (가독성은 위의 스크림 레이어가 담당)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s3,
                    vertical: AppSpacing.s3,
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
                      AppText.caption(_memberSummary(l10n, group)),
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

/// '${owner}님 외 N명' 형태의 멤버 요약. (멤버가 owner 뿐이면 '외 N명' 생략)
String _memberSummary(AppLocalizations l10n, Group group) {
  if (group.memberCount <= 1) {
    return l10n.meetingMemberOwner(group.ownerNickname);
  }
  return l10n.meetingMemberOthers(group.ownerNickname, group.memberCount - 1);
}

/// 사이클 상태 문자열을 한국어 라벨로. (TODO: 서버 status 값 확정 후 보완)
String _statusLabel(AppLocalizations l10n, String status) {
  switch (status) {
    case 'in_progress':
      return l10n.meetingStatusInProgress;
    case 'completed':
      return l10n.meetingStatusCompleted;
    default:
      return status;
  }
}

/// DateTime → 'MM.dd'.
String _formatDate(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '$month.$day';
}
