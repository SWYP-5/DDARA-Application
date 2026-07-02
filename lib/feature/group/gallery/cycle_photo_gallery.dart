import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/model/group/group_detail.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/feature/group/detail/widget/header/started_header.dart';
import 'package:ddara/feature/group/widget/member_photo_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// 따라찍기 사이클에서 멤버 한 명의 사진 카드 데이터.
typedef CycleMemberPhoto = ({
  /// 멤버 이름.
  String name,

  /// 멤버가 따라찍어 올린 사진. null 이면 미업로드 상태.
  ImageProvider? image,

  /// 본인 카드 여부. (본인이고 미업로드면 '촬영하러 가기' 버튼을 보여준다)
  bool isMe,

  /// 사진 잠금 여부. (본인이 아직 안 올려 타인 사진을 가린 상태)
  bool isLocked,
});

/// 스타터(따라찍기 시작) 화면.
///
/// 스타터의 사진을 멤버들이 따라찍은 결과 사진을 모아 보여준다.
/// (헤더 + 모임명 + 멤버 사진 그리드 — 아래 본문은 추후 구현)
class CyclePhotoGallery extends StatelessWidget {
  const CyclePhotoGallery({
    super.key,
    required this.groupId,
    required this.cycleId,
  });

  final int groupId;
  final int cycleId;

  // TODO: 모임 조회 API 응답의 모임 이름으로 대체. (현재 백엔드 스펙 대기 — 임시 더미)
  static const _dummyGroupName = '마라탕 걸즈';

  // TODO: 멤버 목록은 모임 조회 API 응답으로 대체. (백엔드 스펙 대기 — 임시 더미)
  static const _dummyMembers = ['지원', '도윤', '민주', '보현'];

  static final _dummyGroupCycle = GroupCycle(
    cycleId: 0,
    cycleNumber: 3,
    topic: '마라탕 맛있게 먹기',
    starterUserId: 0,
    status: 'in_progress',
    startedAt: DateTime.now(),
    deadlineAt: DateTime.now().add(const Duration(hours: 14)),
    starterNickname: '지원',
    starterImageUrl: '',
  );

  @override
  Widget build(BuildContext context) {
    // TODO: 실제 멤버/업로드 상태로 대체. (현재 더미)
    // 첫 카드를 본인으로 보고, 본인이 아직 업로드하지 않았다고 가정한다.
    final members = <CycleMemberPhoto>[
      for (var i = 0; i < _dummyMembers.length; i++)
        (
          name: _dummyMembers[i],
          // TODO: 실제 업로드 사진으로 대체. (현재 데이터 없어 모두 미업로드)
          image: null,
          isMe: i == 0,
          // 본인이 아직 업로드 안 했으면 타인 사진은 잠근다.
          isLocked: i != 0,
        ),
    ];

    return CupertinoPageScaffold(
      navigationBar: AppBar(
        title: _dummyGroupName,
        onBack: () => context.pop(),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          // 끝에서 더 당겨지는 바운스(overscroll)를 막고 가장자리에서 멈춘다.
          physics: const ClampingScrollPhysics(),
          // 상 s6, 하 s8, 좌우 s4 여백.
          padding: const EdgeInsets.only(
            top: AppSpacing.s6,
            bottom: AppSpacing.s8,
            left: AppSpacing.s4,
            right: AppSpacing.s4,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.s4,
            children: [
              // TODO: 실데이터 연결 시 실제 스타터 이미지 URL 로 교체. (현재 더미 — 빈 URL)
              StartedHeader(imageUri: '', progress: _dummyGroupCycle),
              // 헤더↔제목 간격 s14(56): Column spacing(s4)×2 + 이 SizedBox(s6).
              const SizedBox(height: AppSpacing.s6),
              AppText.headlineLarge(_dummyGroupName),
              // 제목↔그리드 간격 s4 는 Column spacing 으로 처리.
              // 멤버 사진 카드 2칸 그리드. (카드 높이는 225 고정)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSpacing.s3,
                  mainAxisSpacing: AppSpacing.s3,
                  mainAxisExtent: 225,
                ),
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return MemberPhotoCard(
                    name: member.name,
                    image: member.image,
                    // 본인 카드만 촬영 콜백을 연결한다. (타인은 null)
                    onTakePhoto: member.isMe
                        ? () => context.push(
                            RoutePath.startedCamera,
                            // 가이드로 스타터 사진 URL 을 넘긴다.
                            extra: _dummyGroupCycle.starterImageUrl,
                          )
                        : null,
                    isLocked: member.isLocked,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
