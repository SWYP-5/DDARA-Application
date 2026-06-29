import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// 참여한 모임이 하나도 없을 때 보여주는 빈 상태 화면.
class EmptyGroupPage extends StatelessWidget {
  const EmptyGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // 콘텐츠 영역을 전체폭으로 펴서 자식들이 화면 가로 중앙에 오도록 한다.
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AppText.headlineLarge(
                '아직 참여한 모임이 없어요',
                textAlign: TextAlign.center,
              ),
              const AppText.body(
                '첫 판을 시작해 친구들에게 보내보세요',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.s3),
              Image.asset(
                'assets/images/photo_image.png',
                width: 160,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),

        // 하단 액션 영역
        Padding(
          // 하단 여백은 s6, 항목 사이 간격은 s3.
          padding: const EdgeInsets.fromLTRB(20, 0, 20, AppSpacing.s6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.s3,
            children: [
              AppButton(
                label: '모임 만들기',
                onPressed: () => context.push(RoutePath.groupCreate),
              ),
              AppButton.outline(
                label: '모임 참여하기',
                onPressed: () => context.push(RoutePath.groupJoin),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
