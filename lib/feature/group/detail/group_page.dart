import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/widget/app_title.dart';
import 'package:ddara/feature/group/detail/widget/body/history.dart';
import 'package:ddara/feature/group/detail/widget/body/history_photos.dart';
import 'package:ddara/feature/group/detail/widget/body/members.dart';
import 'package:ddara/feature/group/detail/widget/body/record.dart';
import 'package:ddara/feature/group/detail/widget/header/group_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// 모임 화면. (현재는 자리만 잡아둔 상태 — 추후 모임 상세 UI 구현)
class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  // TODO: 모임 조회 API 응답의 모임 이름으로 대체. (현재 백엔드 스펙 대기 — 임시 더미)
  static const _dummyGroupName = '마라탕 걸즈';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // 다른 화면과 동일한 여백 규약.
        padding: const EdgeInsetsDirectional.only(start: 12, end: 16),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          onPressed: () => context.pop(),
          child: const Icon(CupertinoIcons.back, color: AppColors.textPrimary),
        ),
        middle: Text(
          _dummyGroupName,
          style: AppTypography.headlineMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      // imageUri 를 넘기지 않으면 GroupHeader 가 EmptyHeader(빈 상태)를 보여준다.
      child: SafeArea(
        child: SingleChildScrollView(
          // 끝에서 더 당겨지는 바운스(overscroll)를 막고 가장자리에서 멈춘다.
          physics: const ClampingScrollPhysics(),
          // 상하 s6, 좌우 s5 여백.
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s5,
            vertical: AppSpacing.s6,
          ),
          child: Column(
            // 상단부터 쌓되 가로는 중앙 정렬.
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.s5,
            children: [
              GroupHeader(
                navigateToStart: () {
                  // TODO: 스타터(첫 따라찍기) 시작 화면으로 이동.
                },
              ),
              const AppTitle('기록'),
              // TODO: 통계 값은 모임 조회 API 응답으로 대체. (현재 백엔드 스펙 대기 — 임시 더미)
              const Record(ddaraCount: 0, photoCount: 0),
              const SizedBox(height: AppSpacing.s3),
              const AppTitle('사람들'),
              const Members(),
              const SizedBox(height: AppSpacing.s3),
              const AppTitle('지난 따라찍기'),
              const History(),
              const HistoryPhotos()
            ],
          ),
        ),
      ),
    );
  }
}
