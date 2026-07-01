import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/foundation/app_spacing.dart';
import 'package:ddara/core/designsystem/theme/app_colors.dart';
import 'package:ddara/core/widget/profile_avatar.dart';
import 'package:ddara/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';

/// 멤버 아바타·추가 버튼의 원 지름.
const double _circleSize = 60;

/// 모임 멤버 한 명의 표시 데이터.
///
/// TODO: 모임 조회 API 의 멤버 모델로 대체. (백엔드 스펙 대기 — 임시 record)
typedef MemberDisplay = ({String name, String? imageUrl});

/// 모임 멤버 목록. (원형 프로필 + 이름, 끝에 멤버 추가 버튼)
class Members extends StatelessWidget {
  const Members({super.key, required this.members, required this.onAddMember});

  final List<MemberDisplay> members;

  /// 우측 끝 + 버튼(멤버 초대) 탭 콜백.
  final VoidCallback onAddMember;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: AppSpacing.s2,
        children: [
          for (final member in members)
            _MemberAvatar(name: member.name, imageUrl: member.imageUrl),
          // 멤버 목록 끝에 항상 붙는 추가 버튼.
          _AddMemberButton(onPressed: onAddMember),
        ],
      ),
    );
  }
}

/// 원형 프로필 아바타 + 이름 라벨.
class _MemberAvatar extends StatelessWidget {
  const _MemberAvatar({required this.name, required this.imageUrl});

  final String name;

  /// 프로필 이미지 URL. null·빈 값이면 기본 아이콘을 보여준다.
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return _CircleLabel(
      label: name,
      child: ProfileAvatar(size: _circleSize, imageUrl: imageUrl),
    );
  }
}

/// 멤버 목록 끝 + 버튼. 누르면 초대 공유 시트를 연다.
class _AddMemberButton extends StatelessWidget {
  const _AddMemberButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return _CircleLabel(
      label: AppLocalizations.of(context).groupMembersAdd,
      onTap: onPressed,
      child: const SizedBox(
        width: _circleSize,
        height: _circleSize,
        child: Icon(
          CupertinoIcons.add,
          size: 28,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

/// [child](원형 콘텐츠) 아래 caption 라벨을 둔 공통 레이아웃.
///
/// [onTap] 을 주면 [child] 영역이 버튼이 된다.
class _CircleLabel extends StatelessWidget {
  const _CircleLabel({required this.child, required this.label, this.onTap});

  final Widget child;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.s2,
      children: [
        if (onTap != null)
          CupertinoButton(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            onPressed: onTap,
            child: child,
          )
        else
          child,
        AppText.caption(label),
      ],
    );
  }
}
