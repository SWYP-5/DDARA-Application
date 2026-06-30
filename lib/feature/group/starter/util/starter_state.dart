import 'package:flutter/widgets.dart';

/// 스타터 화면에서 현재 보여줄 본문 단계. (촬영으로 시작해 정보 입력으로 넘어간다)
enum StarterStep { camera, info }

class StarterState {
  /// 현재 본문 단계.
  final StarterStep step;

  /// 컨셉 설명 입력값. (단계가 바뀌어도 유지)
  final String concept;

  /// 촬영해 본문에 반영할 사진. null 이면 아직 촬영 전이다.
  final ImageProvider? photo;

  const StarterState({
    this.step = StarterStep.camera,
    this.concept = '',
    this.photo,
  });

  StarterState copyWith({
    StarterStep? step,
    String? concept,
    ImageProvider? photo,
  }) {
    return StarterState(
      step: step ?? this.step,
      concept: concept ?? this.concept,
      photo: photo ?? this.photo,
    );
  }
}
