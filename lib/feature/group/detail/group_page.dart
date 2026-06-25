import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/component/button/app_text_button.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/core/widget/invite_share_sheet.dart';
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
      navigationBar: AppBar(
        title: _dummyGroupName,
        onBack: () => context.pop(),
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
                // TODO: 모임 조회 API 응답으로 대체. (백엔드 스펙 대기 — 임시 더미)
                progress: (
                  round: 3,
                  topic: '마라탕 맛있게 먹기',
                  starterName: '도윤',
                  remainingTime: '14시간',
                ),
                navigateToStart: () {
                  // TODO: 스타터(첫 따라찍기) 시작 화면으로 이동.
                },
                onTakePhoto: () => context.push(RoutePath.startedCamera),
              ),
              const AppText.headlineLarge('기록'),
              // TODO: 통계 값은 모임 조회 API 응답으로 대체. (현재 백엔드 스펙 대기 — 임시 더미)
              const Record(ddaraCount: 0, photoCount: 0),
              const SizedBox(height: AppSpacing.s3),
              const AppText.headlineLarge('사람들'),
              // TODO: 모임 조회 API 응답의 멤버 목록으로 대체. (백엔드 스펙 대기 — 임시 더미)
              Members(
                members: const [
                  (name: '김도윤', imageUrl: null),
                  (name: '주민주', imageUrl: null),
                  (name: '허보현', imageUrl: null),
                ],
                onAddMember: () => InviteShareSheet.show(
                  context,
                  // TODO: 모임 조회 API 응답으로 대체. (백엔드 스펙 대기 — 임시 더미)
                  inviteCode: 'DUMMY1234',
                  // 카카오가 접근 가능한 공개 https URL 이어야 한다. (로컬 에셋 불가)
                  imageUrl: 'https://placehold.co/800x400.png',
                ),
              ),
              const SizedBox(height: AppSpacing.s3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AppText.headlineLarge('지난 따라찍기'),
                  AppTextButton(
                    label: '더보기',
                    onPressed: () {
                      // TODO: 지난 따라찍기 전체 보기 화면으로 이동.
                    },
                  ),
                ],
              ),
              const HistoryPhotos(),
            ],
          ),
        ),
      ),
    );
  }
}
