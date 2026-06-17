import 'package:ddara/core/model/auth/social_login_type.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/feature/signup/provider/notifier_provider.dart';
import 'package:ddara/feature/signup/step/birth_page.dart';
import 'package:ddara/feature/signup/step/nick_name_page.dart';
import 'package:ddara/feature/signup/step/terms_page.dart';
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
      final errorMessage = next.errorMessage;

      if (errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    });

    if (state.isSuccess) {
      context.go(RoutePath.home);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (state.step > 1) {
              notifier.backButtonClicked();
            } else {
              context.pop();
            }
          },
        ),
        title: LinearProgressIndicator(
          value: state.step / 3,
          minHeight: 6,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
      body: switch (state.step) {
        1 => TermsPage(onNextButtonClicked: notifier.nextButtonClicked),
        2 => BirthPage(
          onNextButtonClicked: notifier.nextButtonClicked,
          onChanged: (birth) {
            notifier.birthDayOnChanged(birth);
          },
        ),
        _ => NicknamePage(
          onSignUpButtonClicked: notifier.signUp,
          onChanged: (nickName) {
            notifier.nickNameOnChanged(nickName);
          },
        ),
      },
    );
  }
}
