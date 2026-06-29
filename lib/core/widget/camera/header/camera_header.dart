import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:flutter/cupertino.dart';

/// 카메라 상단 영역. 좌측에 '원본사진 투명도' 라벨 + 선택 탭, 우측에 플래시 버튼.
///
/// 선택 상태(어떤 탭이 켜졌는지)는 내부에서 관리하고,
/// 그에 따른 처리(투명도 적용 · 플래시 토글)는 외부 콜백으로 위임한다.
class CameraHeader extends StatelessWidget {
  const CameraHeader({
    super.key,
    this.showOpacity = false,
    this.flashOn = false,
    required this.onOpacityChanged,
    required this.onFlashPressed,
  });

  /// '원본사진 투명도' 영역(라벨 + 탭) 표시 여부.
  final bool showOpacity;

  /// 플래시 켜짐 여부. 버튼 표시에 반영한다.
  final bool flashOn;

  /// 투명도 탭이 바뀌었을 때. 선택된 라벨('0'/'20'/'40')을 전달한다.
  final ValueChanged<String> onOpacityChanged;

  /// 플래시 버튼을 눌렀을 때.
  final VoidCallback onFlashPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s4,
        vertical: AppSpacing.s3,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showOpacity)
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.s3,
              children: [
                const AppText.label('원본사진 투명도'),
                _OpacityTabs(onChanged: onOpacityChanged),
              ],
            )
          else
            const SizedBox.shrink(),
          _FlashButton(active: flashOn, onPressed: onFlashPressed),
        ],
      ),
    );
  }
}

/// 원본사진 투명도 선택 탭. 선택값은 내부 상태로 두고, 변경 시 [onChanged] 로 알린다.
/// 선택 표시(하얀 원)는 선택된 옵션 위로 슬라이딩 이동한다.
class _OpacityTabs extends StatefulWidget {
  const _OpacityTabs({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  State<_OpacityTabs> createState() => _OpacityTabsState();
}

class _OpacityTabsState extends State<_OpacityTabs> {
  static const _labels = ['0', '20', '40'];
  static const _itemSize = 24.0;
  static const _spacing = AppSpacing.s2;
  static const _duration = Duration(milliseconds: 200);

  int _selectedIndex = _labels.length - 1;

  void _select(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
    widget.onChanged(_labels[index]);
  }

  /// 옵션이 동일 크기·균등 간격이라 alignment.x 를 -1 ~ 1 로 두면
  /// thumb 가 각 옵션 중앙에 정확히 맞는다.
  Alignment get _thumbAlignment {
    if (_labels.length == 1) return Alignment.center;
    final x = _selectedIndex * 2 / (_labels.length - 1) - 1;
    return Alignment(x, 0);
  }

  @override
  Widget build(BuildContext context) {
    final width = _labels.length * _itemSize + (_labels.length - 1) * _spacing;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s1),
      decoration: ShapeDecoration(
        color: AppColors.bgSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      child: SizedBox(
        width: width,
        height: _itemSize,
        child: Stack(
          children: [
            // 슬라이딩 하얀 원(thumb).
            AnimatedAlign(
              duration: _duration,
              curve: Curves.easeOut,
              alignment: _thumbAlignment,
              child: Container(
                width: _itemSize,
                height: _itemSize,
                decoration: ShapeDecoration(
                  color: AppColors.bgWarm,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
              ),
            ),
            // 라벨들. (thumb 위에 얹어 글자색만 전환)
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: _spacing,
              children: [
                for (var i = 0; i < _labels.length; i++)
                  _OpacityOption(
                    label: _labels[i],
                    selected: _selectedIndex == i,
                    size: _itemSize,
                    duration: _duration,
                    onPressed: () => _select(i),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 투명도 탭의 단일 옵션. 배경은 thumb 가 담당하고, 여기선 글자색만 전환한다.
class _OpacityOption extends StatelessWidget {
  const _OpacityOption({
    required this.label,
    required this.selected,
    required this.size,
    required this.duration,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final double size;
  final Duration duration;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: onPressed,
      child: SizedBox(
        width: size,
        height: size,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: duration,
            curve: Curves.easeOut,
            textAlign: TextAlign.center,
            style: AppTypography.caption.copyWith(
              color: selected ? AppColors.bgSurface : AppColors.textPrimary,
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}

class _FlashButton extends StatelessWidget {
  const _FlashButton({required this.active, required this.onPressed});

  /// 플래시 켜짐 여부. 켜지면 배경/아이콘 색을 반전한다.
  final bool active;
  final VoidCallback onPressed;

  static const double _size = 32;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          color: active ? AppColors.bgWarm : AppColors.bgSurfaceAlt,
          shape: BoxShape.circle,
        ),
        child: Icon(
          CupertinoIcons.bolt_fill,
          size: 18,
          color: active ? AppColors.textOnWarm : AppColors.textPrimary,
        ),
      ),
    );
  }
}
