import 'package:flutter/cupertino.dart';

import '../../../core/designsystem/foundation/app_color_primitives.dart';
import '../../../core/designsystem/theme/app_colors.dart';

class Indicator extends StatelessWidget {
  const Indicator({super.key, required this.active});

  /// 현재 페이지 여부. (활성: 강조색 / 비활성: 회색)
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        // 비활성 점은 grayscale500 — 대응하는 semantic 토큰이 없어 primitive 사용.
        color: active
            ? AppColors.accentDefault
            : AppColorPrimitives.grayscale500,
        shape: BoxShape.circle,
      ),
    );
  }
}
