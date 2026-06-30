import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/component/button/app_text_button.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/core/widget/invite_share_sheet.dart';
import 'package:ddara/feature/group/detail/provider/notifier_provider.dart';
import 'package:ddara/feature/group/detail/util/group_page_state.dart';
import 'package:ddara/feature/group/detail/widget/body/members.dart';
import 'package:ddara/feature/group/detail/widget/group_section.dart';
import 'package:ddara/feature/group/detail/widget/header/group_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widget/toast/toast.dart';

/// 모임 화면. 전달받은 [groupId] 로 상세를 조회해 그린다.
class GroupPage extends ConsumerWidget {
  const GroupPage({super.key, required this.groupId});

  /// 진입 시 전달받은 모임 식별자. (이 id 로 모임 상세를 조회)
  final int groupId;

  /// 초대 공유 카드에 넣을 모임 대표 이미지. (카카오가 접근 가능한 공개 https URL)
  // TODO: 모임 대표 이미지로 대체. (현재 응답에 없음 — 임시 placeholder)
  static const _shareImageUrl = 'https://placehold.co/800x400.png';

  /// 초대 시트를 자동으로 띄우는 인원 기준. (이 수 미만이면 띄운다)
  static const _inviteThreshold = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // groupId 를 그대로 provider 에 넘기면 notifier.build(int groupId) 가 받아 로드한다.
    final state = ref.watch(groupPageNotifierProvider(groupId));

    ref.listen(groupPageNotifierProvider(groupId), (prev, next) {
      final errorMessage = next.errorMessage;

      if (errorMessage.isNotEmpty) {
        Toast.showToast(context, errorMessage, type: ToastType.error);
      }

      // 진입해 상세가 처음 로드됐을 때, 인원이 기준 미만이면 초대 시트를 띄운다.
      final detail = next.groupDetail;
      if (prev?.groupDetail == null &&
          detail != null &&
          detail.members.length < _inviteThreshold) {
        // 빌드/네비게이션 도중 모달을 띄우지 않도록 다음 프레임에 연다.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!context.mounted) return;
          InviteShareSheet.show(
            context,
            inviteCode: detail.inviteCode,
            imageUrl: _shareImageUrl,
            // 인원 부족으로 자동으로 띄운 경우라 머리말을 안내 문구로 바꾼다.
            memberShortage: true,
          );
        });
      }
    });

    return CupertinoPageScaffold(
      navigationBar: AppBar(
        title: state.groupDetail?.name ?? '',
        onBack: () => context.pop(),
      ),
      child: SafeArea(child: _body(context, state)),
    );
  }

  Widget _body(BuildContext context, GroupPageState state) {
    if (state.isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    final groupDetail = state.groupDetail;
    if (groupDetail == null) {
      return Center(
        child: AppText.body(
          state.errorMessage.isEmpty ? '모임 정보를 불러오지 못했어요.' : state.errorMessage,
        ),
      );
    }

    return SingleChildScrollView(
      // 끝에서 더 당겨지는 바운스(overscroll)를 막고 가장자리에서 멈춘다.
      physics: const ClampingScrollPhysics(),
      // 상하 s6, 좌우 s4 여백.
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s4,
        vertical: AppSpacing.s6,
      ),
      child: Column(
        // 상단부터 쌓되 가로는 중앙 정렬.
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.s8,
        children: [
          GroupHeader(
            // 진행 중인 사이클을 그대로 전달. null 이면 헤더가 빈 상태를 보여준다.
            progress: groupDetail.currentCycle,
            navigateToStart: () => context.push(RoutePath.starter),
            onTakePhoto: () => context.push(RoutePath.started),
          ),
          GroupSection(
            title: const AppText.headlineLarge('사람들'),
            body: Members(
              members: groupDetail.members
                  .map(
                    (member) => (
                      name: member.nickname,
                      imageUrl: member.profileImageUrl,
                    ),
                  )
                  .toList(),
              onAddMember: () => InviteShareSheet.show(
                context,
                inviteCode: groupDetail.inviteCode,
                imageUrl: _shareImageUrl,
              ),
            ),
          ),
          GroupSection(
            title: Row(
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
            // HistoryPhotos 는 2차 MVP 예정 — 같은 높이(카드 225 + 상하 여백)로 빈 상태 안내.
            body: SizedBox(
              height: 225 + AppSpacing.s4 * 2,
              child: const Center(child: AppText.body('지난 따라찍기가 아직 없어요')),
            ),
          ),
        ],
      ),
    );
  }
}
