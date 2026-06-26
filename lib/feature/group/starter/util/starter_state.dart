import 'package:flutter/widgets.dart';

/// 스타터 화면에서 현재 보여줄 본문 단계.
enum StarterStep { info, camera, photoCheck }

class StarterState {
  /// 현재 본문 단계.
  final StarterStep step;

  /// 컨셉 설명 입력값. (단계가 바뀌어도 유지)
  final String concept;

  /// 방금 촬영해 확인 화면에서 보여줄 사진. null 이면 아직 촬영 전이다.
  final ImageProvider? captured;

  /// 확정된(올리기 한) 사진. null 이면 아직 등록 전이다.
  final ImageProvider? photo;

  const StarterState({
    this.step = StarterStep.info,
    this.concept = '',
    this.captured,
    this.photo,
  });

  StarterState copyWith({
    StarterStep? step,
    String? concept,
    ImageProvider? captured,
    ImageProvider? photo,
  }) {
    return StarterState(
      step: step ?? this.step,
      concept: concept ?? this.concept,
      captured: captured ?? this.captured,
      photo: photo ?? this.photo,
    );
  }
}
