import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/widget/app_dialog.dart';
import 'package:ddara/feature/group/follower/follower_camera.dart';
import 'package:ddara/feature/group/follower/follower_photo_check.dart';
import 'package:ddara/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// 따라찍기 촬영 화면. 공유 AppBar 하나 아래에서 촬영/사진 확인 본문만 교체한다.
class FollowerCameraPage extends StatefulWidget {
  const FollowerCameraPage({super.key, required this.guideImageUrl});

  /// 따라찍기 가이드(스타터가 미리 찍은) 사진 URL.
  final String guideImageUrl;

  @override
  State<FollowerCameraPage> createState() => _FollowerCameraPageState();
}

class _FollowerCameraPageState extends State<FollowerCameraPage> {
  /// 촬영된 사진 경로. null 이면 촬영 단계, 값이 있으면 사진 확인 단계.
  String? _capturedPath;

  @override
  Widget build(BuildContext context) {
    final capturedPath = _capturedPath;
    final l10n = AppLocalizations.of(context);

    return CupertinoPageScaffold(
      navigationBar: AppBar(title: l10n.followerCameraTitle),
      child: capturedPath == null
          ? FollowerCamera(
              guideImageUrl: widget.guideImageUrl,
              // 촬영하면 사진 확인 단계로 전환한다.
              onCapture: (path) => setState(() => _capturedPath = path),
            )
          : FollowerPhotoCheck(
              imagePath: capturedPath,
              // 다시 찍기 → 촬영 단계로 돌아간다.
              onRetake: () => setState(() => _capturedPath = null),
              onUpload: () async {
                // 게시는 되돌릴 수 없으므로 확인을 한 번 받는다.
                final ok = await AppDialog.show(
                  context,
                  title: l10n.photoPostWarningTitle,
                  confirmLabel: l10n.commonConfirm,
                );
                if (!ok) return;
                // TODO: 따라찍기 사진 업로드. (백엔드 스펙 대기)
                if (!context.mounted) return;
                // 스택을 유지한 채(go 로 초기화하지 않고) 바로 아래의
                // CyclePhotoGallery(/group/follower) 로 돌아간다.
                // TODO: provider 연동 시 업로드한 사진이 반영되도록 갱신 추가.
                context.pop();
              },
            ),
    );
  }
}