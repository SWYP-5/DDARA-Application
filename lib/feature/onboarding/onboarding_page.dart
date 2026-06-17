import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/feature/onboarding/provider/onboarding_provider.dart';
import 'package:ddara/feature/onboarding/widget/onboarding_first_page.dart';
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
            Expanded(
              child: PageView.builder(
                controller: _controller,
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLastPage ? _start : _goNext,
                  child: Text(isLastPage ? '시작하기' : '다음'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
