import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DdaraInvitationAnimation extends StatefulWidget {
  const DdaraInvitationAnimation({
    super.key,
    this.size,
    this.onComplete,
    this.onReveal,
    this.revealAt = 0.5,
  });

  /// 정사각형 한 변 크기(px). null이면 부모 제약을 따른다.
  final double? size;

  /// 재생이 끝났을 때 호출되는 콜백.
  final VoidCallback? onComplete;

  /// 재생 진행도가 [revealAt] 을 처음 넘는 순간(편지지가 열릴 때쯤) 호출된다.
  final VoidCallback? onReveal;

  /// [onReveal] 을 발화시킬 진행도(0~1). 기본 0.5(중간).
  final double revealAt;

  @override
  State<DdaraInvitationAnimation> createState() =>
      _DdaraInvitationAnimationState();
}

class _DdaraInvitationAnimationState extends State<DdaraInvitationAnimation>
    with SingleTickerProviderStateMixin {
  static const String _asset =
      'assets/lottie/ddara-invitation-open-transparent.json';

  late final AnimationController _controller = AnimationController(vsync: this);

  /// onReveal 중복 발화 방지.
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });
    // 진행도가 revealAt 을 처음 넘으면 onReveal 을 한 번 발화한다.
    _controller.addListener(() {
      if (!_revealed && _controller.value >= widget.revealAt) {
        _revealed = true;
        widget.onReveal?.call();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      _asset,
      controller: _controller,
      width: widget.size,
      height: widget.size,
      fit: BoxFit.contain,
      // 로드되면 에셋 길이에 맞춰 한 번 재생한다.
      onLoaded: (composition) {
        _controller
          ..duration = composition.duration
          ..forward();
      },
    );
  }
}
