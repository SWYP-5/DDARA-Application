import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/widget/profile_avatar.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/designsystem/component/text/app_text.dart';

/// 프로필 화면 상단 헤더.
///
/// 80 크기의 [ProfileAvatar] 아래에 사용자 이름을 보여준다.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, this.imageUrl, required this.name});

  /// 프로필 이미지 URL. null·빈 값이면 기본 아이콘을 보여준다.
  final String? imageUrl;

  /// 사용자 이름.
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppSpacing.s2,
        children: [
          ProfileAvatar(size: 80, imageUrl: imageUrl),
          AppText.headlineLarge(name),
        ],
      ),
    );
  }
}
