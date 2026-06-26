import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/feature/group/starter/provider/notifier_provider.dart';
import 'package:ddara/feature/group/starter/starter_camera.dart';
import 'package:ddara/feature/group/starter/starter_info.dart';
import 'package:ddara/feature/group/starter/starter_photo_check.dart';
import 'package:ddara/feature/group/starter/util/starter_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// 스타터 시작 화면. 본문(정보 입력 · 촬영 · 사진 확인)만 단계별로 교체한다.
class StarterPage extends ConsumerWidget {
  const StarterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final step = ref.watch(starterNotifierProvider.select((s) => s.step));
    final notifier = ref.read(starterNotifierProvider.notifier);

    final body = switch (step) {
      StarterStep.info => const StarterInfo(),
      StarterStep.camera => const StarterCamera(),
      StarterStep.photoCheck => const StarterPhotoCheck(),
    };

    return CupertinoPageScaffold(
      navigationBar: AppBar(
        title: '스타터 시작하기',
        // 단계에 따라 뒤로가기 동작을 달리한다.
        onBack: () {
          if (step == StarterStep.info) {
            context.pop();
          } else if (step == StarterStep.photoCheck) {
            notifier.retake();
          } else {
            notifier.backToInfo();
          }
        },
      ),
      child: body,
    );
  }
}
