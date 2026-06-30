import 'package:ddara/core/widget/camera/camera.dart';
import 'package:flutter/cupertino.dart';

/// 따라찍기 촬영 본문. (가이드 사진 위에 투명도·모드 컨트롤 포함)
///
/// 촬영하면 [onCapture] 로 사진 경로를 넘기고, 단계 전환은 상위에서 처리한다.
class StartedCamera extends StatelessWidget {
  const StartedCamera({super.key, required this.onCapture});

  /// 촬영 완료 시 저장된 이미지 파일 경로를 전달한다.
  final ValueChanged<String> onCapture;

  @override
  Widget build(BuildContext context) {
    return Camera(
      // TODO: 모임 상태에 따라 투명도/모드 영역 표시 여부 결정.
      showOpacity: true,
      showViewMode: true,
      // TODO: 친구가 미리 찍은 사진으로 교체. (현재 테스트용 임시 이미지)
      guideImage: const AssetImage('assets/images/temp_image.jpg'),
      onCapture: onCapture,
    );
  }
}