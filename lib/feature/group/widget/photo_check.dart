import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/widget/camera/bottom/camera_bottom.dart';
import 'package:ddara/core/widget/camera/header/camera_header.dart';
import 'package:flutter/cupertino.dart';

/// 촬영한 사진을 확인하는 본문.
///
/// 카메라와 동일한 구조를 쓰되, 프리뷰 영역만 촬영 이미지로 바꾸고
/// 나머지 컨트롤(헤더 플래시 · 하단 갤러리/촬영/전환)은 영역만 남긴 채 숨긴다.
/// 하단에는 '다시 찍기'(테두리) · '올리기'(채움) 버튼을 둔다.
class PhotoCheck extends StatelessWidget {
  const PhotoCheck({
    super.key,
    this.image,
    required this.onRetake,
    required this.onUpload,
  });

  /// 확인할 촬영 이미지. null 이면 임시 이미지로 대체한다.
  final ImageProvider? image;

  /// '다시 찍기' 를 눌렀을 때.
  final VoidCallback onRetake;

  /// '올리기' 를 눌렀을 때.
  final VoidCallback onUpload;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 헤더: 구성은 빠지지만 높이는 유지해 이미지 영역을 카메라와 맞춘다.
        Visibility(
          visible: false,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: CameraHeader(onOpacityChanged: (_) {}),
        ),
        // 프리뷰 영역 → 촬영 이미지.
        Expanded(
          child: SizedBox.expand(
            child: Image(
              image: image ?? const AssetImage('assets/images/temp_image.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // 하단: 카메라 컨트롤 영역을 유지한 채 다시찍기/올리기 버튼을 올린다.
        Stack(
          children: [
            Visibility(
              visible: false,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: CameraBottom(onViewModeChanged: (_) {}),
            ),
            Positioned(
              left: AppSpacing.s5,
              right: AppSpacing.s5,
              bottom: AppSpacing.s6,
              child: Row(
                spacing: AppSpacing.s3,
                children: [
                  Expanded(
                    child: AppButton.outline(
                      label: '다시 찍기',
                      onPressed: onRetake,
                    ),
                  ),
                  Expanded(
                    child: AppButton(
                      label: '올리기',
                      onPressed: onUpload,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
