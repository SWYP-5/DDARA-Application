import 'package:ddara/core/designsystem/component/app_button.dart';
import 'package:ddara/core/designsystem/component/logo.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/feature/onboarding/provider/onboarding_provider.dart';
import 'package:ddara/feature/onboarding/widget/onboarding_first_page.dart';
import 'package:ddara/feature/onboarding/widget/onboarding_page_indicator.dart';
import 'package:ddara/feature/onboarding/widget/onboarding_second_page.dart';
import 'package:ddara/feature/onboarding/widget/onboarding_third_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  static const _pageCount = 3;

  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goNext() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _start() async {
    // 온보딩 완료 플래그 저장 → 다음 실행부터는 노출되지 않는다.
    await ref.read(onboardingControllerProvider).complete();
    if (!mounted) return;

    context.go(RoutePath.login);
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _index == _pageCount - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 로고·텍스트·인디케이터를 한 덩어리로 화면 중앙에 모은다.
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 페이지가 바뀌어도 고정되는 로고
                  const LogoLarge(),
                  const SizedBox(height: AppSpacing.s6),
                  // 제목·설명만 좌우로 스와이프되는 영역 (고정 높이)
                  SizedBox(
                    height: 120,
                    child: PageView.builder(
                      controller: _controller,
                      // 스와이프 비활성화 → 버튼으로만 페이지 이동.
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _pageCount,
                      onPageChanged: (index) => setState(() => _index = index),
                      itemBuilder: (_, index) {
                        switch (index) {
                          case 0:
                            return const OnboardingFirstPage();
                          case 1:
                            return const OnboardingSecondPage();
                          default:
                            return const OnboardingThirdPage();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s6),
                  // 페이지가 바뀌어도 고정되며, 활성 점만 애니메이션으로 전환되는 인디케이터
                  OnboardingPageIndicator(currentIndex: _index),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppButton(
                label: isLastPage ? '시작하기' : '다음',
                onPressed: isLastPage ? _start : _goNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
