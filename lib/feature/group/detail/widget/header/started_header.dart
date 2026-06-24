import 'dart:ui' show ImageFilter;

import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 진행 중인 따라찍기 정보. (헤더 표시용)
///
/// TODO: 모임 조회 API 모델로 대체. (백엔드 스펙 대기 — 임시 record)
typedef DdaraProgress = ({
  /// 회차. (3 → '3번째 따라찍기')
  int round,

  /// 따라찍기 주제. ('마라탕 맛있게 먹기')
  String topic,

  /// 시작한 멤버 이름. ('도윤' → '도윤님이 시작했어요')
  String starterName,

  /// 남은 시간 표시 문자열. ('14시간' → '진행 중 · 14시간 남음')
  String remainingTime,
});

/// 모임에 따라찍기가 시작된 뒤 상단에 보여주는 헤더. ([EmptyHeader] 의 반대 상태)
///
/// 대표 이미지를 중심으로 구성하며, 우측 하단 토글 버튼으로 펼침/접힘을 전환한다.
class StartedHeader extends StatefulWidget {
  const StartedHeader({
    super.key,
    required this.imageUri,
    required this.progress,
    required this.onTakePhoto,
  });

  /// 대표로 보여줄 이미지 URI.
  final String imageUri;

  /// 진행 중인 따라찍기 정보.
  final DdaraProgress progress;

  /// 하단 '촬영하러 가기' 버튼을 눌렀을 때 실행할 콜백.
  final VoidCallback onTakePhoto;

  @override
  State<StartedHeader> createState() => _StartedHeaderState();
}

class _StartedHeaderState extends State<StartedHeader> {
  /// 헤더 펼침 여부. (true: 큰 이미지 헤더 / false: 축소된 헤더)
  bool _expanded = true;

  void _toggle() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          // 위 고정 헤더라 접힐 때 위에서부터 높이가 줄도록 상단 기준 정렬.
          alignment: Alignment.topCenter,
          crossFadeState: _expanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: _buildExpanded(),
          secondChild: _buildCollapsed(),
        ),
        const SizedBox(height: AppSpacing.s5),
        AppButton(label: '촬영하러 가기', onPressed: widget.onTakePhoto),
      ],
    );
  }

  /// 펼친 상태: 대표 이미지 + 진행 정보 + 하단 그라데이션.
  Widget _buildExpanded() {
    return Container(
      width: double.infinity,
      height: 478,
      padding: const EdgeInsets.only(top: AppSpacing.s4),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        // TODO: API 연동 시 NetworkImage(imageUri) 로 교체. (현재는 임시 에셋)
        image: const DecorationImage(
          image: AssetImage('assets/images/temp_image.jpg'),
          fit: BoxFit.cover,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppSpacing.s4,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: AppSpacing.s4,
              children: [
                AppText.caption(
                  '진행 중 · ${widget.progress.remainingTime} 남음',
                  textAlign: TextAlign.center,
                  color: AppColors.textPrimary,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 202,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.s5),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.50, 1.00),
                end: const Alignment(0.50, 0.26),
                colors: [Colors.black, Colors.black.withValues(alpha: 0)],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [_buildInfoRow()],
            ),
          ),
        ],
      ),
    );
  }

  /// 접은 상태: 블러 처리된 대표 이미지 배경 위 진행 정보만.
  Widget _buildCollapsed() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Stack(
        children: [
          // 블러 처리된 대표 이미지 배경.
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              // TODO: API 연동 시 NetworkImage(imageUri) 로 교체. (현재는 임시 에셋)
              child: Image.asset(
                'assets/images/temp_image.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 텍스트 대비를 위한 어두운 오버레이 + 진행 정보.
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.s5),
            color: Colors.black.withValues(alpha: 0.50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [_buildInfoRow()],
            ),
          ),
        ],
      ),
    );
  }

  /// 진행 정보(회차·제목·시작자) + 펼침/접힘 토글 버튼 한 줄.
  Widget _buildInfoRow() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 10,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.s1,
              children: [
                AppText.label(
                  '${widget.progress.round}번째 따라찍기',
                  textAlign: TextAlign.center,
                  color: AppColors.textAccent,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.s1,
                  children: [
                    AppText.display(
                      widget.progress.topic,
                      textAlign: TextAlign.center,
                    ),
                    AppText.body(
                      '${widget.progress.starterName}님이 시작했어요',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildToggleButton(),
        ],
      ),
    );
  }

  /// 펼침/접힘 토글 버튼. (펼침: ∧ / 접힘: ∨)
  Widget _buildToggleButton() {
    return GestureDetector(
      onTap: _toggle,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.s3),
        decoration: ShapeDecoration(
          color: const Color(0x1E949494),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
        ),
        child: Icon(
          _expanded ? CupertinoIcons.chevron_up : CupertinoIcons.chevron_down,
          size: 24,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
