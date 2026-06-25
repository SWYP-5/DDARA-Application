import 'package:ddara/core/deeplink/pending_invite.dart';
import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/component/loading/app_loading_overlay.dart';
import 'package:ddara/core/model/auth/social_login_type.dart';
import 'package:ddara/core/widget/error_message_dialog.dart';
import 'package:ddara/feature/sign/signup/provider/notifier_provider.dart';
import 'package:ddara/feature/sign/signup/step/birth_page.dart';
import 'package:ddara/feature/sign/signup/step/nick_name_page.dart';
import 'package:ddara/feature/sign/signup/step/terms_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final social = GoRouterState.of(context).extra as SocialLoginType;
    final state = ref.watch(signNotifierProvider(social));
    final notifier = ref.read(signNotifierProvider(social).notifier);

    ref.listen(signNotifierProvider(social), (prev, next) {
      if (prev?.isSuccess == false && next.isSuccess) {
        // 보관된 초대코드가 있으면 모임 참여로 복귀, 없으면 홈으로.
        routeAfterAuth(ref, GoRouter.of(context));
        return;
      }

      final errorMessage = next.errorMessage;

      if (errorMessage.isNotEmpty) {
        showErrorMessageDialog(context, message: errorMessage);
      }
    });

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (state.step > 1) {
          notifier.backButtonClicked();
        } else {
          context.pop();
        }
      },
      child: CupertinoPageScaffold(
        navigationBar: AppBar(
          onBack: () {
            if (state.step > 1) {
              notifier.backButtonClicked();
            } else {
              context.pop();
            }
          },
        ),
        child: SafeArea(
          // birth/nickname 스텝이 아직 Material 위젯(TextField/ElevatedButton)을
          // 사용하므로 Material ancestor 를 제공한다. 해당 스텝 Cupertino 전환 시 제거 가능.
          child: Material(
            type: MaterialType.transparency,
            child: Stack(
              children: [
                switch (state.step) {
                  1 => TermsPage(
                    initialAgreed: state.termsAgreed,
                    onNextButtonClicked: notifier.nextButtonClicked,
                    onAgreementChanged: notifier.termsAgreedChanged,
                  ),
                  2 => BirthPage(
                    initialValue: state.birthDay,
                    onNextButtonClicked: notifier.nextButtonClicked,
                    onChanged: (birth) {
                      notifier.birthDayOnChanged(birth);
                    },
                  ),
                  _ => NicknamePage(
                    initialValue: state.nickName,
                    onSignUpButtonClicked: notifier.signUp,
                    onChanged: (nickName) {
                      notifier.nickNameOnChanged(nickName);
                    },
                  ),
                },

                // 회원가입 처리 중 로딩 오버레이 (입력 차단 + 인디케이터)
                if (state.isLoading) const AppLoadingOverlay(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
