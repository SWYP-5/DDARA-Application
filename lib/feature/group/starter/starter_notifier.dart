import 'package:ddara/feature/group/starter/util/starter_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StarterNotifier extends AutoDisposeNotifier<StarterState> {
  @override
  StarterState build() {
    return const StarterState();
  }

  void conceptChanged(String concept) {
    state = state.copyWith(concept: concept);
  }

  /// 촬영 화면으로 전환.
  void goToCamera() {
    state = state.copyWith(step: StarterStep.camera);
  }

  /// 촬영 완료 → 촬영본을 본문(info)에 바로 반영하고 본문으로 전환.
  void capture(String path) {
    state = state.copyWith(
      step: StarterStep.info,
      photoPath: path,
    );
  }
}
