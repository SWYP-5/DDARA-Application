import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/widget/profile_avatar.dart';
import 'package:flutter/widgets.dart';

/// 모임 참여 확인 화면의 본문. (모임 정보 + 멤버 미리보기)
///
/// 스캐폴드·하단 버튼은 상위 [JoinConfirmPage] 가 들고 있고, 이 위젯은 가운데에
/// 모일 콘텐츠만 그린다. (참여 버튼 클릭 후 다른 본문으로 교체할 수 있도록 분리)
class JoinConfirmBody extends StatelessWidget {
  const JoinConfirmBody({
    super.key,
    required this.groupName,
    required this.subtitle,
    required this.memberSummary,
    required this.memberAvatarUrls,
  });

  /// 참여할 모임 이름.
  final String groupName;

  /// 이름 아래 보조 정보. (예: '2026. 06.28 개설 · 7명')
  final String subtitle;

  /// 멤버 아바타 묶음 아래 요약. (예: '마라탕 킬러님 외 2명이 함께하고 있어요')
  final String memberSummary;

  /// 보여줄 멤버 아바타 슬롯. 각 원소가 null·빈 값이면 기본 아바타로 표시한다.
  /// (0~2개가 넘어오며, 2개일 때 겹쳐 보여준다)
  final List<String?> memberAvatarUrls;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.s7,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.s1,
            children: [
              AppText.display(groupName, textAlign: TextAlign.center),
              AppText.body(subtitle, textAlign: TextAlign.center),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.s3,
            children: [
              _MemberAvatars(avatarUrls: memberAvatarUrls),
              AppText.body(memberSummary, textAlign: TextAlign.center),
            ],
          ),
        ],
      ),
    );
  }
}

/// 멤버 아바타를 겹쳐 보여주는 묶음.
///
/// 넘어온 [avatarUrls] 슬롯(최대 2개)을 그대로 보여주고, 두 번째 아바타를
/// 첫 아바타의 5시 방향(우하단)에 겹쳐 올린다. 각 슬롯이 null 이면 기본 아바타.
class _MemberAvatars extends StatelessWidget {
  const _MemberAvatars({required this.avatarUrls});

  final List<String?> avatarUrls;

  /// 아바타 한 변 크기.
  static const double _size = 56;

  /// 두 번째 아바타의 5시 방향 겹침 오프셋. (작을수록 더 겹친다 · x·y 동일)
  static const double _offset = 20;

  @override
  Widget build(BuildContext context) {
    final shown = avatarUrls.take(2).toList();
    if (shown.isEmpty) return const SizedBox(height: _size);
    if (shown.length == 1) return _Avatar(url: shown.first);

    // 첫 아바타(좌상단) 위에 두 번째 아바타를 5시 방향(우하단)으로 겹친다.
    const extent = _size + _offset;
    return SizedBox(
      width: extent,
      height: extent,
      child: Stack(
        children: [
          Positioned(left: 0, top: 0, child: _Avatar(url: shown[0])),
          Positioned(
            left: _offset,
            top: _offset,
            child: _Avatar(url: shown[1]),
          ),
        ],
      ),
    );
  }
}

/// 원형 멤버 아바타. [ProfileAvatar] 를 쓰되, 겹침이 드러나도록 배경색(bg-base)
/// 테두리 링으로 감싼다.
class _Avatar extends StatelessWidget {
  const _Avatar({required this.url});

  /// 링 두께.
  static const double _ring = 4;

  /// null·빈 값이면 [ProfileAvatar] 가 기본 아바타를 보여준다.
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _MemberAvatars._size,
      height: _MemberAvatars._size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        border: Border.fromBorderSide(
          BorderSide(color: AppColors.bgBase, width: _ring),
        ),
      ),
      // 링(_ring) 두께만큼 안쪽에 아바타가 들어간다.
      child: ProfileAvatar(
        size: _MemberAvatars._size - _ring * 2,
        imageUrl: url,
      ),
    );
  }
}
