import 'package:ddara/core/model/auth/social_login_type.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/feature/signup/provider/notifier_provider.dart';
import 'package:ddara/feature/signup/step/birth_page.dart';
import 'package:ddara/feature/signup/step/nick_name_page.dart';
import 'package:ddara/feature/signup/step/terms_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        context.go(RoutePath.home);
        return;
      }

      final errorMessage = next.errorMessage;

      if (errorMessage.isNotEmpty) {
        showCupertinoDialog(
          context: context,
          builder: (dialogContext) => CupertinoAlertDialog(
            content: Text(errorMessage),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('확인'),
              ),
            ],
          ),
        );
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
        navigationBar: CupertinoNavigationBar(
          padding: const EdgeInsetsDirectional.only(start: 12, end: 16),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            onPressed: () {
              if (state.step > 1) {
                notifier.backButtonClicked();
              } else {
                context.pop();
              }
            },
            child: const Icon(CupertinoIcons.back, color: Colors.white),
          ),
        ),
        child: SafeArea(
          // birth/nickname 스텝이 아직 Material 위젯(TextField/ElevatedButton)을
          // 사용하므로 Material ancestor 를 제공한다. 해당 스텝 Cupertino 전환 시 제거 가능.
          child: Material(
            type: MaterialType.transparency,
            child: switch (state.step) {
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
          ),
        ),
      ),
    );
  }
}
