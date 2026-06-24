import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/designsystem/component/button/app_button.dart';

/// 모임에 아직 따라찍기가 하나도 없을 때 상단에 보여주는 빈 상태 헤더.
///
/// 제목 + 안내 문구 + 일러스트로 구성하며, 화면 상단에 가로 중앙 정렬로 배치한다.
class EmptyHeader extends StatelessWidget {
  const EmptyHeader({super.key, required this.navigateToStart});

  /// '스타터 시작하기' 버튼을 눌렀을 때 실행할 콜백.
  final VoidCallback navigateToStart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // 상하 s7, 좌우 s5 여백.
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s5,
        vertical: AppSpacing.s7,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppSpacing.s1,
        children: [
          const AppText.headlineLarge(
            '아직 따라찍기가 없어요',
            textAlign: TextAlign.center,
          ),
          const AppText.caption(
            '첫 판을 시작해 친구들에게 보내보세요',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.s1),
          Image.asset(
            'assets/images/photo_image.png',
            width: 160,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: AppSpacing.s5),
          AppButton(label: '내가 먼저 시작하기', onPressed: navigateToStart),
        ],
      ),
    );
  }
}
