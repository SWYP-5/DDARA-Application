import 'dart:io';

import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/core/widget/app_dialog.dart';
import 'package:ddara/feature/group/widget/photo_check.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// 따라찍기(started) 촬영 후 사진을 확인하는 화면.
class StartedPhotoCheckPage extends StatelessWidget {
  const StartedPhotoCheckPage({super.key, required this.imagePath});

  /// 촬영된 이미지 파일 경로.
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const AppBar(),
      child: PhotoCheck(
        image: FileImage(File(imagePath)),
        // 다시 찍기 → 카메라로 돌아간다.
        onRetake: () => context.pop(),
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
          context.go(RoutePath.started);
        },
      ),
    );
  }
}
