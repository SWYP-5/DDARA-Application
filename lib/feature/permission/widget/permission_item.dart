import 'package:flutter/cupertino.dart';

import '../../../core/designsystem/component/text/app_text.dart';
import '../../../core/designsystem/theme/app_colors.dart';

/// 개별 권한 항목 카드. (아이콘 · 제목 · 설명)
class PermissionItem extends StatefulWidget {
  const PermissionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  State<PermissionItem> createState() => _PermissionItemState();
}

class _PermissionItemState extends State<PermissionItem> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 카드 전체 영역이 탭에 반응하도록
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          // 누르는 동안 살짝 어둡게.
          color: _pressed ? AppColors.bgSurface : AppColors.bgSurfaceAlt,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12,
          children: [
            // 좌측 아이콘 (임시 — 추후 권한별 아이콘으로 교체)
            Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Icon(widget.icon, size: 24, color: AppColors.textPrimary),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 3,
                children: [
                  AppText.label(widget.title, color: AppColors.textPrimary),
                  AppText.caption(widget.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
