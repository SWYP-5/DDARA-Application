import 'dart:ui' show ImageFilter;

import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:flutter/cupertino.dart';

/// 멤버 사진 카드. 배경 이미지 위에 하단 이름 라벨을 표시한다.
/// 이미지와 이름은 외부에서 주입한다.
///
/// - 이미지가 없을 때: 본인 카드([onTakePhoto] 주입)면 '촬영하러 가기' 버튼을,
///   그 외에는 갤러리 아이콘을 가운데에 보여준다.
/// - [isLocked] 이면(본인이 아직 업로드 안 함) 타인 사진을 블러 처리하고
///   가운데에 자물쇠 아이콘을 표시한다.
class MemberPhotoCard extends StatelessWidget {
  const MemberPhotoCard({
    super.key,
    this.image,
    required this.name,
    this.onTakePhoto,
    this.isLocked = false,
  });

  /// 카드 배경 이미지. null 이면 가운데에 placeholder(버튼/아이콘)를 보여준다.
  final ImageProvider? image;

  /// 하단에 표시할 멤버 이름.
  final String name;

  /// 본인 카드이고 아직 미업로드일 때 '촬영하러 가기' 버튼을 눌렀을 때의 콜백.
  /// null 이면 본인 카드가 아니므로 갤러리 아이콘을 표시한다.
  final VoidCallback? onTakePhoto;

  /// 본인이 아직 업로드하지 않아 타인 사진이 잠긴 상태. (블러 + 자물쇠)
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    final image = this.image;
    final onTakePhoto = this.onTakePhoto;
    // 잠금은 보여줄 사진이 있을 때만 의미가 있다.
    final locked = isLocked && image != null;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: SizedBox(
        width: double.infinity,
        height: 225,
        child: Stack(
          children: [
            // 배경: 이미지(잠금 시 블러) 또는 surface.
            Positioned.fill(
              child: image == null
                  ? const ColoredBox(color: AppColors.bgSurface)
                  : (locked
                        ? ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaX: 12,
                              sigmaY: 12,
                            ),
                            child: Image(image: image, fit: BoxFit.cover),
                          )
                        : Image(image: image, fit: BoxFit.cover)),
            ),
            // 잠금: 가운데 자물쇠.
            if (locked)
              const Center(
                child: Icon(
                  CupertinoIcons.lock_fill,
                  size: 32,
                  color: AppColors.textPrimary,
                ),
              )
            // 사진이 없을 때: 본인이면 촬영 버튼, 아니면 갤러리 아이콘.
            else if (image == null)
              Center(
                child: onTakePhoto != null
                    ? _TakePhotoButton(onPressed: onTakePhoto)
                    : const Icon(
                        CupertinoIcons.photo,
                        size: 32,
                        color: AppColors.textSecondary,
                      ),
              ),
            // 하단 이름 라벨.
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.s3),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s3,
                    vertical: AppSpacing.s1,
                  ),
                  decoration: ShapeDecoration(
                    color: AppColors.overlayScrim,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                  ),
                  child: AppText.label(name, color: AppColors.textPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 본인 미업로드 카드 가운데에 표시하는 '촬영하러 가기' 버튼.
/// 둥근(pill) 흰색 배경 위에 라벨 텍스트를 둔다.
class _TakePhotoButton extends StatelessWidget {
  const _TakePhotoButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s4,
          vertical: AppSpacing.s2,
        ),
        decoration: const ShapeDecoration(
          color: AppColors.textPrimary,
          shape: StadiumBorder(),
        ),
        child: const AppText.label('촬영하러 가기', color: AppColors.textOnWarm),
      ),
    );
  }
}
