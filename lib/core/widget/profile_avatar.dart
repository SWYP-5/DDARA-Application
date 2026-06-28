import 'package:ddara/core/designsystem/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 기본 아이콘이 아바타 지름에서 차지하는 비율.
const double _iconRatio = 0.6;

/// 원형 프로필 아바타.
///
/// [imageUrl] 이 있으면 네트워크 이미지를, 없거나 로드 실패하면
/// 기본 프로필(사람) 아이콘을 [size] 지름의 원 안에 보여준다.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required this.size, this.imageUrl});

  /// 아바타 원 지름.
  final double size;

  /// 프로필 이미지 URL. null·빈 값이면 기본 아이콘을 보여준다.
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    final hasImage = url != null && url.isNotEmpty;

    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: AppColors.bgSurfaceAlt,
        shape: BoxShape.circle,
        border: Border.fromBorderSide(
          BorderSide(color: AppColors.borderDefault),
        ),
      ),
      child: hasImage
          ? Image.network(
              url,
              fit: BoxFit.cover,
              // 로드 실패 시 기본 아이콘으로 대체.
              errorBuilder: (context, error, stackTrace) =>
                  _DefaultIcon(size: size),
            )
          : _DefaultIcon(size: size),
    );
  }
}

/// 이미지가 없거나 로드 실패했을 때의 기본 프로필 아이콘.
class _DefaultIcon extends StatelessWidget {
  const _DefaultIcon({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/images/ic_user.svg',
        width: size * _iconRatio,
        height: size * _iconRatio,
        // 아이콘 원본 색이 배경과 같으므로 밝은 회색으로 덮어 대비를 준다.
        colorFilter: const ColorFilter.mode(
          AppColors.textSecondary,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
