import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// 스타터 시작 화면. (본문은 추후 구현)
class StarterPage extends StatelessWidget {
  const StarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: AppBar(
        title: '스타터 시작하기',
        onBack: () => context.pop(),
      ),
      child: const SafeArea(child: SizedBox.shrink()),
    );
  }
}
