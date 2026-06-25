import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/feature/group/camera/widget/camera.dart';
import 'package:flutter/cupertino.dart';

class StartedCameraPage extends StatelessWidget {
  const StartedCameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: AppBar(),
      child: Camera(),
    );
  }
}
