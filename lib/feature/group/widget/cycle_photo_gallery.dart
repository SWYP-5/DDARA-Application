import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/model/group/group_detail.dart';
import 'package:ddara/feature/group/detail/widget/header/started_header.dart';
import 'package:ddara/feature/group/widget/member_photo_card.dart';
import 'package:flutter/cupertino.dart';

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

/// 스타터의 사진을 멤버들이 따라찍은 결과 사진을 모아 보여주는 본문.
/// (헤더 + 모임명 + 멤버 사진 그리드)
///
/// 표시 데이터는 모두 외부에서 주입한다. (여러 화면에서 재사용)
class CyclePhotoGallery extends StatelessWidget {
  const CyclePhotoGallery({
    super.key,
    required this.groupName,
    required this.progress,
    required this.headerImageUri,
    required this.members,
    this.onTakePhoto,
  });

  /// 상단 제목에 쓰는 모임 이름.
  final String groupName;

  /// 진행 중인 따라찍기(사이클) 정보. 헤더에 전달한다.
  final GroupCycle progress;

  /// 헤더 대표 이미지 URI.
  final String headerImageUri;

  /// 멤버 사진 카드에 그릴 멤버 목록.
  final List<CycleMemberPhoto> members;

  /// 본인 카드(미업로드)에서 '촬영하러 가기' 를 눌렀을 때.
  /// null 이면(예: 종료된 사이클) 본인 카드에도 촬영 버튼을 보여주지 않는다.
  final VoidCallback? onTakePhoto;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          StartedHeader(imageUri: headerImageUri, progress: progress),
          // 헤더↔제목 간격 s14(56): Column spacing(s4)×2 + 이 SizedBox(s6).
          const SizedBox(height: AppSpacing.s6),
          AppText.headlineLarge(groupName),
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
                onTakePhoto: member.isMe ? onTakePhoto : null,
                isLocked: member.isLocked,
              );
            },
          ),
        ],
      ),
    );
  }
}