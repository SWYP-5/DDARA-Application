import 'package:ddara/core/designsystem/design_system.dart';
import 'package:flutter/widgets.dart';

/// 지난 따라찍기 사진들. (살짝 회전된 카드들을 가로로 나열)
///
/// 카드 합 너비가 화면보다 넓을 수 있어 가로 스크롤로 감싼다.
class HistoryPhotos extends StatelessWidget {
  const HistoryPhotos({super.key});

  /// 카드 한 장의 실제 너비.
  static const double _cardWidth = 180;

  /// 각 카드가 가로로 차지하는 너비. (작을수록 더 많이 겹침)
  static const double _visibleWidth = 170;

  /// 마지막 카드가 자기 영역 밖으로 삐져나오는 폭. (오른쪽 여백으로 보정)
  static const double _overhang = _cardWidth - _visibleWidth;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      // 회전/겹침으로 삐져나온 모서리가 잘리지 않도록 여백. (오른쪽은 overhang 만큼 더)
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s5,
        AppSpacing.s4,
        AppSpacing.s5 + _overhang,
        AppSpacing.s4,
      ),
      // TODO: 사진/이름 데이터는 모임 조회 API 응답으로 대체.
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // 각 카드의 가로 점유폭을 줄여(widthFactor) 다음 카드가 위로 겹치게 한다.
        children: const [
          _OverlapCard(
            cardWidth: _cardWidth,
            visibleWidth: _visibleWidth,
            child: _PhotoCard(angle: -0.14, name: '나', radius: AppRadius.lg),
          ),
          _OverlapCard(
            cardWidth: _cardWidth,
            visibleWidth: _visibleWidth,
            child: _PhotoCard(angle: 0.14, name: '보현', radius: AppRadius.sm),
          ),
          _OverlapCard(
            cardWidth: _cardWidth,
            visibleWidth: _visibleWidth,
            child: _PhotoCard(angle: -0.10, name: '민주', radius: AppRadius.lg),
          ),
        ],
      ),
    );
  }
}

/// 카드의 가로 점유폭을 [visibleWidth] 로 줄여 다음 카드가 위로 겹치게 하는 래퍼.
///
/// [child] 는 원래 크기([cardWidth])로 그려지되, 레이아웃상으로는 [visibleWidth] 만
/// 차지하므로 오른쪽 부분이 다음 카드 아래로 깔린다.
class _OverlapCard extends StatelessWidget {
  const _OverlapCard({
    required this.cardWidth,
    required this.visibleWidth,
    required this.child,
  });

  final double cardWidth;
  final double visibleWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: visibleWidth / cardWidth,
      // 세로는 child 높이에 맞춘다. (가로 스크롤이라 세로 제약이 무한대일 수 있음)
      heightFactor: 1,
      child: child,
    );
  }
}

/// 회전된 단일 사진 카드. (사진 영역 + 이름 라벨)
class _PhotoCard extends StatelessWidget {
  const _PhotoCard({
    required this.angle,
    required this.name,
    required this.radius,
  });

  /// 카드 회전 각(라디안).
  final double angle;

  /// 카드 하단에 표시할 이름.
  final String name;

  /// 카드 모서리 둥글기.
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: 180,
        height: 225,
        padding: const EdgeInsets.all(AppSpacing.s3),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColors.bgSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 2,
              offset: Offset(-2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 60,
          children: [
            // TODO: 사진/스티커 영역. (가로 중앙 자리만 잡아둠)
            const SizedBox(
              width: double.infinity,
              child: Center(child: SizedBox.square(dimension: 36)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s3,
                vertical: AppSpacing.s1,
              ),
              decoration: ShapeDecoration(
                color: AppColors.overlayScrim,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
              ),
              child: Text(
                name,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  height: 1.38,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
