import 'package:ddara/core/designsystem/design_system.dart';
import 'package:flutter/cupertino.dart';

/// 모임 화면. (현재는 자리만 잡아둔 상태 — 추후 모임 상세 UI 구현)
class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Text(
            'Group',
            style: AppTypography.headlineMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
