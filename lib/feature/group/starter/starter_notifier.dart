import 'package:ddara/feature/group/starter/util/starter_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StarterNotifier extends Notifier<StarterState> {
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

  /// 촬영 완료 → 사진 확인 화면으로 전환.
  void capture() {
    state = state.copyWith(step: StarterStep.photoCheck);
  }

  /// 다시 찍기 → 촬영 화면으로.
  void retake() {
    state = state.copyWith(step: StarterStep.camera);
  }

  /// 올리기 → 촬영 사진을 본문(info)에 반영한다.
  void upload() {
    state = state.copyWith(
      step: StarterStep.info,
      // TODO: 실제 촬영 이미지로 교체. (현재 테스트용 임시 이미지)
      photo: const AssetImage('assets/images/temp_image.jpg'),
    );
  }

  /// 본문(info)으로 돌아가기. (카메라에서 뒤로)
  void backToInfo() {
    state = state.copyWith(step: StarterStep.info);
  }
}
