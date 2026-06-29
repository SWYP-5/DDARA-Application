import 'dart:io';

import 'package:ddara/feature/group/starter/util/starter_state.dart';
import 'package:flutter/widgets.dart';
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

  /// 촬영 완료 → 촬영본을 들고 사진 확인 화면으로 전환.
  void capture(String path) {
    state = state.copyWith(
      step: StarterStep.photoCheck,
      captured: FileImage(File(path)),
    );
  }

  /// 다시 찍기 → 촬영 화면으로.
  void retake() {
    state = state.copyWith(step: StarterStep.camera);
  }

  /// 올리기 → 방금 촬영한 사진을 본문(info)에 반영한다.
  void upload() {
    final captured = state.captured;
    if (captured == null) return;
    state = state.copyWith(step: StarterStep.info, photo: captured);
  }

  /// 본문(info)으로 돌아가기. (카메라에서 뒤로)
  void backToInfo() {
    state = state.copyWith(step: StarterStep.info);
  }
}
