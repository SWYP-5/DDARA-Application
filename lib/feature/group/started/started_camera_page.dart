import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/widget/app_dialog.dart';
import 'package:ddara/feature/group/started/started_camera.dart';
import 'package:ddara/feature/group/started/started_photo_check.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// 따라찍기 촬영 화면. 공유 AppBar 하나 아래에서 촬영/사진 확인 본문만 교체한다.
class StartedCameraPage extends StatefulWidget {
  const StartedCameraPage({super.key});

  @override
  State<StartedCameraPage> createState() => _StartedCameraPageState();
}

class _StartedCameraPageState extends State<StartedCameraPage> {
  /// 촬영된 사진 경로. null 이면 촬영 단계, 값이 있으면 사진 확인 단계.
  String? _capturedPath;

  @override
  Widget build(BuildContext context) {
    final capturedPath = _capturedPath;

    return CupertinoPageScaffold(
      navigationBar: const AppBar(title: '따라찍기'),
      child: capturedPath == null
          ? StartedCamera(
              // 촬영하면 사진 확인 단계로 전환한다.
              onCapture: (path) => setState(() => _capturedPath = path),
            )
          : StartedPhotoCheck(
              imagePath: capturedPath,
              // 다시 찍기 → 촬영 단계로 돌아간다.
              onRetake: () => setState(() => _capturedPath = null),
              onUpload: () async {
                // 게시는 되돌릴 수 없으므로 확인을 한 번 받는다.
                final ok = await AppDialog.show(
                  context,
                  title: '게시되면 수정이 불가능합니다.',
                  confirmLabel: '확인',
                );
                if (!ok) return;
                // TODO: 따라찍기 사진 업로드. (백엔드 스펙 대기)
                if (!context.mounted) return;
                // 스택을 유지한 채(go 로 초기화하지 않고) 바로 아래의
                // StartedPage(/group/started) 로 돌아간다.
                // TODO: provider 연동 시 업로드한 사진이 반영되도록 갱신 추가.
                context.pop();
              },
            ),
    );
  }
}