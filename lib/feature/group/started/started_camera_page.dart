import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/core/widget/camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class StartedCameraPage extends StatelessWidget {
  const StartedCameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const AppBar(),
      child: Camera(
        // TODO: 모임 상태에 따라 투명도/모드 영역 표시 여부 결정.
        showOpacity: true,
        showViewMode: true,
        // TODO: 친구가 미리 찍은 사진으로 교체. (현재 테스트용 임시 이미지)
        guideImage: const AssetImage('assets/images/temp_image.jpg'),
        // 촬영하면 사진 확인 화면으로 이동한다.
        onCapture: (path) =>
            context.push(RoutePath.startedPhotoCheck, extra: path),
      ),
    );
  }
}
